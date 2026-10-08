#!/usr/bin/env bash
# Print the last N Claude Code releases from the official changelog.
#   changelog.sh [N]                 last N releases (default 1)
#   changelog.sh --since <version>   every release newer than <version>
#   changelog.sh --installed         every release newer than the installed CLI
set -uo pipefail

URL="https://raw.githubusercontent.com/anthropics/claude-code/main/CHANGELOG.md"
mode=count n=1 since=""
installed="$(claude --version 2>/dev/null | awk '{print $1}')"
case "${1:-}" in
  --since) mode=since; since="${2:?--since needs a version}";;
  --installed) mode=since; since="$installed";;
  "") ;;
  *) n="$1";;
esac

log="$(curl -sfL --max-time 20 "$URL")" || { echo "ERROR: could not fetch $URL" >&2; exit 2; }
latest_noted="$(awk '/^## /{print $2; exit}' <<<"$log")"
# npm can be ahead of the changelog for a few hours after a release.
published="$(npm view @anthropic-ai/claude-code version --fetch-timeout=8000 --fetch-retries=0 2>/dev/null || true)"

echo "installed:          ${installed:-unknown}"
echo "latest in changelog: $latest_noted"
[ -n "$published" ] && ! grep -q "^## $published\$" <<<"$log" &&
  echo "latest published:    $published (no changelog entry yet)"
[ -n "$installed" ] && [ "$installed" != "${published:-$latest_noted}" ] &&
  echo "behind by:           $(awk -v v="$installed" '/^## /{if($2==v)exit; c++} END{print c+0}' <<<"$log") noted release(s)"
echo

awk -v mode="$mode" -v n="$n" -v since="$since" '
  /^## / {
    seen++
    if (mode == "count" && seen > n) exit
    if (mode == "since" && $2 == since) exit
  }
  seen > 0 { print }
' <<<"$log"
