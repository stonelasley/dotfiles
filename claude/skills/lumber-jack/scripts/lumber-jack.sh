#!/usr/bin/env bash
# lumber-jack: remove git worktrees whose PR merged, or that are abandoned.
# Deterministic by design so it can run hourly with no model in the loop.
#
# Usage: lumber-jack.sh [--dry-run] [--idle-days N] [--grace-hours N] [--repo PATH]
#
# A worktree is cut when ALL of these hold:
#   - not the main worktree, not the one we're running in, not `git worktree lock`ed
#   - clean (`git status --porcelain` empty; ignored bin/obj don't count)
#   - no running process has its path on the command line
#   - no activity (commit, index, reflog) within --grace-hours
#   - and one of:
#       MERGED    its branch's PR merged on GitHub and local HEAD is contained in the merged head
#       CLOSED    its branch's only PRs were closed without merging
#       IDLE      no PR at all and no activity for --idle-days
# Branch is deleted only for MERGED. CLOSED/IDLE keep the branch (re-add with `git worktree add`).
set -u

DRY_RUN=0
IDLE_DAYS=7
GRACE_HOURS=2
REPO="$PWD"
while [ $# -gt 0 ]; do
    case "$1" in
        --dry-run) DRY_RUN=1 ;;
        --idle-days) IDLE_DAYS="$2"; shift ;;
        --grace-hours) GRACE_HOURS="$2"; shift ;;
        --repo) REPO="$2"; shift ;;
        -h|--help) sed -n '2,19p' "$0"; exit 0 ;;
        *) echo "unknown arg: $1" >&2; exit 2 ;;
    esac
    shift
done

cd "$REPO" 2>/dev/null || { echo "ERROR: cannot cd to $REPO" >&2; exit 2; }
git rev-parse --git-dir >/dev/null 2>&1 || { echo "ERROR: $REPO is not a git repo" >&2; exit 2; }

COMMON_DIR="$(cd "$(git rev-parse --git-common-dir)" && pwd)"
MAIN_WT="$(git worktree list --porcelain | sed -n '1s/^worktree //p')"
SELF_WT="$(git rev-parse --show-toplevel 2>/dev/null || true)"
TRASH="$COMMON_DIR/lumber-jack-trash"
LOG="$COMMON_DIR/lumber-jack.log"
LOCK="$COMMON_DIR/lumber-jack.lock"
NOW=$(date +%s)
IDLE_SECS=$((IDLE_DAYS * 86400))
GRACE_SECS=$((GRACE_HOURS * 3600))

log() { echo "$*"; logf "$*"; }
logf() { [ "$DRY_RUN" = 1 ] || echo "$(date '+%F %T') $*" >> "$LOG"; }
norm() { printf '%s' "$1" | tr '\\' '/' | tr '[:upper:]' '[:lower:]' | sed -E 's#^/([a-z])/#\1:/#'; }

# One run at a time (the hourly scheduler and a manual run can overlap).
if ! mkdir "$LOCK" 2>/dev/null; then
    if [ -n "$(find "$LOCK" -maxdepth 0 -mmin +120 2>/dev/null)" ]; then
        rmdir "$LOCK" 2>/dev/null; mkdir "$LOCK" 2>/dev/null || { echo "locked by another run"; exit 0; }
    else
        echo "another lumber-jack run is in progress; exiting"; exit 0
    fi
fi
trap 'rmdir "$LOCK" 2>/dev/null' EXIT

# Finish deleting anything a previous run moved to the trash but didn't get through.
[ "$DRY_RUN" = 1 ] || { [ -d "$TRASH" ] && rm -rf "$TRASH"/* 2>/dev/null; }

git worktree prune 2>/dev/null

# PR state per branch: one gh call for the whole repo.
PR_TSV=""
GH_OK=0
if command -v gh >/dev/null 2>&1; then
    if PR_TSV="$(gh pr list --state all --limit 3000 \
        --json number,headRefName,state,headRefOid \
        --jq '.[] | [.headRefName, .state, .headRefOid, (.number|tostring)] | @tsv' 2>/dev/null)"; then
        GH_OK=1
    fi
fi
if [ "$GH_OK" = 0 ]; then
    log "WARN gh unavailable or failed; PR state unknown, running report-only"
    DRY_RUN=1
fi

# Command lines of every running process, lowercased, forward slashes.
if command -v powershell.exe >/dev/null 2>&1; then
    PROCS="$(powershell.exe -NoProfile -Command \
        "Get-CimInstance Win32_Process | ForEach-Object { \$_.CommandLine }" 2>/dev/null \
        | tr '\\' '/' | tr '[:upper:]' '[:lower:]')"
else
    PROCS="$(ps -eo args 2>/dev/null | tr '[:upper:]' '[:lower:]')"
fi

mtime() { [ -e "$1" ] && stat -c %Y "$1" 2>/dev/null || echo 0; }

cut=0; kept=0; failed=0
REPORT=""
row() { REPORT+="$(printf '%-7s %-9s %-55s %s' "$1" "$2" "$3" "$4")"$'\n'; }

remove_worktree() {
    local path="$1"
    git worktree remove --force "$path" >/dev/null 2>&1 || true
    git worktree prune 2>/dev/null
    if git worktree list --porcelain | grep -qxF "worktree $path"; then
        return 1
    fi
    # --force often half-succeeds on Windows (deregisters, then "Directory not empty").
    # Moving to the trash is instant on the same volume; the slow delete happens after.
    if [ -e "$path" ]; then
        mkdir -p "$TRASH"
        mv "$path" "$TRASH/$(basename "$path")-$NOW" 2>/dev/null || return 1
    fi
    return 0
}

while IFS=$'\t' read -r path head branch locked; do
    [ -z "$path" ] && continue
    name="${path#"$MAIN_WT"/}"
    [ "$path" = "$MAIN_WT" ] && continue
    [ -n "$SELF_WT" ] && [ "$(norm "$path")" = "$(norm "$SELF_WT")" ] && { row KEEP self "$name" "current worktree"; kept=$((kept+1)); continue; }
    [ "$locked" = 1 ] && { row KEEP locked "$name" "git worktree lock"; kept=$((kept+1)); continue; }

    if [ ! -d "$path" ]; then continue; fi

    if [ -n "$(git --no-optional-locks -C "$path" status --porcelain --ignore-submodules=all 2>/dev/null | head -1)" ]; then
        row KEEP dirty "$name" "${branch:-detached}: uncommitted changes"; kept=$((kept+1)); continue
    fi

    np="$(norm "$path")"
    if [ -n "$PROCS" ] && printf '%s' "$PROCS" | grep -qF "$np"; then
        row KEEP live "$name" "${branch:-detached}: a running process references it"; kept=$((kept+1)); continue
    fi

    gitdir="$(git -C "$path" rev-parse --absolute-git-dir 2>/dev/null)"
    last_commit=$(git -C "$path" log -1 --format=%ct 2>/dev/null || echo 0)
    last=$last_commit
    for t in $(mtime "$gitdir/index") $(mtime "$gitdir/logs/HEAD") $(mtime "$gitdir/HEAD"); do
        [ "$t" -gt "$last" ] && last=$t
    done
    age=$((NOW - last))
    age_h=$((age / 3600))

    if [ "$age" -lt "$GRACE_SECS" ]; then
        row KEEP recent "$name" "${branch:-detached}: active ${age_h}h ago"; kept=$((kept+1)); continue
    fi

    verdict=""; reason=""; delete_branch=0
    if [ -n "$branch" ] && [ "$GH_OK" = 1 ]; then
        prs="$(printf '%s\n' "$PR_TSV" | awk -F'\t' -v b="$branch" '$1==b')"
        if printf '%s\n' "$prs" | awk -F'\t' '$2=="OPEN"' | grep -q .; then
            n="$(printf '%s\n' "$prs" | awk -F'\t' '$2=="OPEN"{print $4; exit}')"
            row KEEP open-pr "$name" "$branch: PR #$n open"; kept=$((kept+1)); continue
        fi
        merged="$(printf '%s\n' "$prs" | awk -F'\t' '$2=="MERGED"{print $3"\t"$4; exit}')"
        if [ -n "$merged" ]; then
            oid="${merged%%$'\t'*}"; n="${merged##*$'\t'}"
            if [ "$head" != "$oid" ] && ! git cat-file -e "$oid^{commit}" 2>/dev/null; then
                git fetch -q origin "refs/pull/$n/head" 2>/dev/null
            fi
            if [ "$head" = "$oid" ] || git merge-base --is-ancestor "$head" "$oid" 2>/dev/null; then
                verdict=MERGED; reason="$branch: PR #$n merged"; delete_branch=1
            else
                row KEEP new-work "$name" "$branch: PR #$n merged but local has commits after it"; kept=$((kept+1)); continue
            fi
        elif printf '%s\n' "$prs" | awk -F'\t' '$2=="CLOSED"' | grep -q .; then
            n="$(printf '%s\n' "$prs" | awk -F'\t' '$2=="CLOSED"{print $4; exit}')"
            verdict=CLOSED; reason="$branch: PR #$n closed unmerged, idle ${age_h}h"
        fi
    fi
    if [ -z "$verdict" ]; then
        if [ "$age" -ge "$IDLE_SECS" ]; then
            verdict=IDLE; reason="${branch:-detached}: no PR, idle $((age / 86400))d"
        else
            row KEEP young "$name" "${branch:-detached}: no PR, idle $((age / 86400))d < ${IDLE_DAYS}d"; kept=$((kept+1)); continue
        fi
    fi

    if [ "$DRY_RUN" = 1 ]; then
        row WOULD "$verdict" "$name" "$reason$([ $delete_branch = 1 ] && echo ' (+branch)')"; cut=$((cut+1)); continue
    fi
    if remove_worktree "$path"; then
        extra=""
        if [ "$delete_branch" = 1 ] && git branch -D "$branch" >/dev/null 2>&1; then
            extra=" (+branch, was $(git rev-parse --short "$head"))"
        fi
        row CUT "$verdict" "$name" "$reason$extra"; logf "CUT $verdict $path $reason$extra"; cut=$((cut+1))
    else
        row FAIL "$verdict" "$name" "$reason: remove failed (locked file / open process?)"; logf "FAIL $path"; failed=$((failed+1))
    fi
done < <(git worktree list --porcelain | awk '
    /^worktree /{ if (p!="") print p"\t"h"\t"b"\t"l; p=substr($0,10); h=""; b=""; l=0 }
    /^HEAD /{ h=$2 }
    /^branch /{ b=$2; sub("refs/heads/","",b) }
    /^locked/{ l=1 }
    END{ if (p!="") print p"\t"h"\t"b"\t"l }')

printf '%s' "$REPORT" | sort
mode=$([ "$DRY_RUN" = 1 ] && echo "dry-run" || echo "live")
summary="lumber-jack ($mode): $([ "$DRY_RUN" = 1 ] && echo would-cut || echo cut) $cut, kept $kept, failed $failed"
echo "$summary"
[ "$DRY_RUN" = 1 ] || echo "$(date '+%F %T') $summary" >> "$LOG"

# Slow part last so the report is already out if this times out; next run finishes it.
[ "$DRY_RUN" = 1 ] || { [ -d "$TRASH" ] && rm -rf "$TRASH"/* 2>/dev/null; }
exit 0
