---
name: claude-audit
description: Audit how a repo uses Claude Code (its skills, slash commands, subagents, hooks, settings, permissions, MCP servers, CLAUDE.md files, and the user-level ~/.claude layer on top) against the latest Claude Code releases, then produce a ranked list of concrete improvements that make Claude more effective, cheaper, faster, simpler, or easier to maintain. Takes an optional release count (default 1) or `--since <version>` / `--installed`. Use whenever the user asks to audit, review, tune, optimize, clean up, or modernize their Claude setup, .claude folder, skills, commands or hooks; asks "what's new in Claude Code that we should use", "are we using Claude well", "why are sessions so expensive or slow", "check the changelog against our setup"; or wants to know whether a recent release makes any of their custom tooling obsolete.
---

# claude-audit

Your job is to find the handful of changes worth making, back each one with evidence, and offer
to apply them. A long list of plausible observations is a worse result than five sharp findings.
Rank ruthlessly.

## Arguments

- A number `N`: audit against the last N releases (default 1).
- `--since <version>`: every release newer than that version.
- `--installed`: every release newer than the installed CLI. Use this when the user says "since I
  last updated", or when the installed version is behind latest.
- `--repo-only`: skip the user layer. Use it when the audit is for a team repo whose readers don't
  share your `~/.claude`.

## 1. Gather: one call

```bash
python3 ~/.claude/skills/claude-audit/scripts/gather.py [--releases N | --since V | --installed] [--repo-only]
```

It runs the inventory, the usage scan of local transcripts and the changelog fetch, then prints a
digest of about 10–20k characters:
- versions, and how far behind the installed CLI is
- headline costs
- a usage summary
- **rule-based suspects** with evidence
- the changelog entries that touch config surfaces, with a count of what was filtered out

When a TypeSafe key is available (`$TYPESAFE_API_KEY`, or `~/.zshrc.local` / `~/.claude/.env`), the
digest also uses Jev, a fast typed-decision model:
- **Changelog triage.** Every entry that survives the noise filter is labelled adopt / act /
  unblock / irrelevant against a profile of this setup, scored, and capped.
- **File leads.** Repo commands, skills and large CLAUDE.md files are scored for "procedure a
  script could run", "model routing in prose", "reference-heavy" and "self-contradiction".

Both are leads with probabilities, not findings: confirm before reporting. They cost a fraction of
a cent per audit (the digest prints the cost line). Without a key, the digest falls back to keyword
ranking and says so.

Full tables go to the work dir it names (`inventory.md`, `usage.md`, `changelog.md`,
`changelog-ranked.md`).

Work from the digest. Everything you pull into context gets re-read on every later turn, so the
digest is meant to replace reading:
- Never `cat` or `Read` the full data files. `rg` them for the one row you need.
- Don't re-derive anything the digest already measured (usage counts, hook errors, sizes).

If `~/.claude/skills/claude-audit` doesn't resolve, use this SKILL.md's directory. If the changelog
fetch fails, the digest says so. Finish the audit without it and label that section "not checked".
Don't reconstruct release notes from memory.

## 2. Audit

Read `references/checklist.md` for the lenses. The suspects list is where to start, not the answer:
- Confirm each suspect you'll report.
- Drop the ones that don't hold up. A rule fired, but the context makes it fine.
- Look for what rules can't see: overlap between artifacts, instructions that contradict each
  other, workflow design.

The checklist covers what to look for beyond the suspects.

**Read budget.** Aim for about 12 tool calls after gather.
- Batch the evidence for several findings into one Bash call, e.g.
  `sed -n 55,62p a.json; rg -n 'model' b.md | head`.
- Read line ranges, not whole files.
- Check a file's size before opening it. Anything over ~300 lines gets `rg -n` first.

Spending calls on a suspect you won't report is waste. Spending them on a finding you'll rank in
the top three is the point.

- Repo-layer artifacts are the ones this audit can fix directly. User-layer and plugin findings go
  in the report too, marked with their layer.
- Plugin and vendored files are third-party. Recommend disabling or replacing them, never editing.
- Don't fan out to subagents. The digest makes a single pass cheaper than coordinating several.

Verify before you claim. Quote the line for each finding. For a changelog "Adopt" item, confirm
that the artifact it replaces really does what you think it does.

## 3. Report

Use this structure:

```markdown
# Claude Code audit: <repo> (<date>)

Installed <v> · latest <v> · changelog slice <v1>…<vN> · layers <repo, user>

## Top findings
| # | Finding | Lens | Layer | Impact | Effort |
|---|---------|------|-------|--------|--------|
| 1 | One line: what to change | cost | repo | high | S |

### 1. <title>
**Where:** `path:line` (quote the relevant line or frontmatter)
**Change:** the concrete edit, as a diff or exact frontmatter/setting where practical
**Why:** the effect, quantified when the inventory allows it (≈tokens per session, hooks per call)
**Changelog:** `<version>`: the entry, if this came from a release; otherwise omit the line

## From the changelog
Adopt / Unblock / Act, one bullet each with the inventory item it touches. End with
"N entries not relevant to this setup."

## Looked at, no change
One line on areas that came out clean, so the user knows they were covered.
```

If the CLI is behind and the skipped releases fix things this setup relies on, the upgrade goes
in the table as a ranked finding, not as a note in the header (checklist lens 0).

Rank by impact ÷ effort. Impact is measured by what the change saves or prevents, not by how
interesting it is. Stop at the findings you'd defend. Usually that's 5 to 12. Mark uncertain items
"unverified" inline rather than leaving them out.

## 4. Save, then offer fixes

1. Show the report in chat.
2. Save it to `${CLAUDE_AUDIT_REPORT_DIR:-~/Projects/notebook/personal/research/tech}/YYYY-MM-DD-claude-audit-<repo-name>.md`,
   creating the directory if needed, and give the path. If a guard blocks the write (some
   environments stop subagents from writing report files), say so and return the full report
   text so the caller can save it. Don't route around the guard.
3. Ask which findings to apply, by number. Edit nothing before the user picks. When you apply
   them, change only the files the chosen findings named. For settings files, show the diff first.
   A wrong `permissions` or `hooks` entry can lock the user out or silently disable a guard.
