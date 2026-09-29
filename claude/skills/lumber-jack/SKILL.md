---
name: lumber-jack
description: Clean up git worktrees in the current repo — removes worktrees whose branch's PR has merged (including squash merges) and ones that are abandoned (PR closed unmerged, or no PR and idle 7+ days), while never touching dirty, live, locked, or recently active trees. Run once, hourly via `/loop 1h /lumber-jack`, or as a zero-token Windows scheduled task. Use whenever the user mentions stale/old/leftover worktrees, `.claude/worktrees` piling up, disk filling from worktrees, pruning or sweeping worktrees, or cleaning up after merged branches.
model: haiku
effort: low
allowed-tools: Bash, PowerShell
---

# lumber-jack

All decisions live in `scripts/lumber-jack.sh`. Your job is to run it and relay the result — don't re-derive or second-guess its verdicts, and don't inspect worktrees yourself. That keeps each tick cheap and the behavior deterministic.

## Run

From the repo the user is in:

```bash
bash ~/.claude/skills/lumber-jack/scripts/lumber-jack.sh [--dry-run] [--idle-days N] [--grace-hours N]
```

Use a 600000 ms timeout; the final trash delete can be slow on Windows. If it times out after printing the summary line, that's fine — the next run finishes the delete.

- The user said "what would", "preview", "check" → pass `--dry-run`.
- Otherwise run live. Removal only drops the checkout: abandoned branches are kept (re-add with `git worktree add <path> <branch>`), and merged branches are deleted only when local HEAD is contained in the merged PR head.

## Report

Reply with only: the summary line, the `CUT`/`WOULD`/`FAIL` rows, and a one-line count of kept rows by reason (e.g. "kept: 5 open-pr, 2 dirty, 3 recent"). Nothing else when running under `/loop`; if `cut 0` and no FAIL, just the summary line.

`FAIL` usually means an old `claude -w` session or editor holds the folder. Tell the user; don't kill processes.

## Hourly

- **In-session:** `/loop 1h /lumber-jack` (runs on Haiku).
- **Zero-token, no open session (Windows):** `pwsh ~/.claude/skills/lumber-jack/scripts/schedule.ps1 -Repo <repo>`; add `-Remove` to unregister. Log lands in `<git-common-dir>/lumber-jack.log`.

## Protecting a worktree

`git worktree lock <path>` — the script skips locked trees.
