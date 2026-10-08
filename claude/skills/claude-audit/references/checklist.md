# Audit lenses

Each lens is a question to ask of the inventory, with the evidence that answers it. These are
prompts for judgment rather than rules. A finding needs a concrete file and a concrete change. If
you can't name both, it isn't a finding.

Feature names below were current when this was written. Before you recommend a setting or
frontmatter field, confirm it exists: check the changelog slice, `claude --help`, or ask the
`claude-code-guide` agent. A recommendation built on a field that doesn't exist costs the user more
than saying nothing.

## Contents
0. Version currency
1. Always-on cost (what every session pays)
2. Per-call cost and latency (hooks)
3. Model routing
4. Determinism (move work out of the prompt)
5. Triggering (descriptions)
6. Duplication and drift
7. Dead weight
8. Permissions friction
9. Maintainability
10. Changelog cross-reference
11. Outside the .claude folder (CI, worktrees)

## 0. Version currency
If the installed CLI is behind and the skipped releases fix things this setup depends on (`/loop`
or scheduled tasks, background or worktree subagents, workflows, MCP transports, hooks it uses),
upgrading is a finding in its own right. It's often the top one, because it's one command and it
unlocks every Adopt item. Name the concrete fixes that matter to this setup, not "stay current".
Note anything to watch on the first run after upgrading (protocol changes, the need to restart
long-running loops).

## 1. Always-on cost
Every session pays for root and user CLAUDE.md files plus their `@imports`, and for the description
of every model-visible skill, command and agent, before the user types anything.
- A CLAUDE.md over ~200 lines usually holds reference material that belongs in a skill or a
  `references/` file that loads on demand. Nested CLAUDE.md files load only when Claude reads
  files under them, so they cost less, but a nested file of 800+ lines still burns context on the
  first read in that subtree.
- Skill descriptions should say when to trigger, in about 200 to 600 characters. A description over
  ~1,000 characters is usually carrying body content.
- A skill the model never needs to pick on its own (deploy, release, destructive ops, personal
  workflows that are always typed by hand) can be removed from the listing:
  `disable-model-invocation: true` in frontmatter, or a `skillOverrides` entry.
- Enabled plugins whose skills are never used still cost their descriptions every session.

## 2. Per-call cost and latency
The inventory line "sync command hooks per event" shows the hooks that block. A catch-all
(no-matcher) `PreToolUse` or `PostToolUse` hook runs on every tool call, so ten catch-all hooks at
100 ms each add a second to every call.
- Narrow the matcher, mark logging/telemetry hooks `async`, set a `timeout` on anything that does
  network or disk work.
- Several hooks running the same script with different matchers usually collapse into one entry with
  an `A|B|C` matcher.
- A hook that emits `additionalContext` on every prompt is always-on cost (lens 1) in disguise.
  Estimate its size.
- Hooks that shell out to `bun`/`node`/`python` pay interpreter startup on every call. Check
  whether a shell one-liner or the built-in permission rules would do.
- **Broken hooks.** The inventory's `resolves` column flags a hook whose interpreter or script is
  missing on this machine, and the usage report's "Hook errors" table shows how often it fails.
  A hook that fails every session is a top finding: the work it was meant to do never happens.
  Platform-specific commands (`powershell` on a Mac) are the usual cause.
- **Hook input.** Hooks receive their payload as JSON on stdin. The inventory's `env_vars` column
  lists variables a hook command relies on, beyond `$CLAUDE_PROJECT_DIR`, `$CLAUDE_PLUGIN_ROOT`
  and `$HOME`. Check each against the hooks docs. One the harness doesn't set expands to an empty
  string, and the hook only works if its script falls back to stdin. Relative script paths
  (`./scripts/x.sh`) break when the session's cwd moves, as it does in worktrees and subdirs.
  `"$CLAUDE_PROJECT_DIR"/...` doesn't.
- The usage report's "Context injected by hooks" table is measured, not estimated. Multiply the
  average by how often it fires to get the real per-session cost.

## 3. Model routing
- A skill or command that runs a script and relays the result (inventory, cleanup, formatting,
  status checks) should not run on the session's top model. Set `model: haiku` (or sonnet) and a
  low `effort` in frontmatter.
- Subagent definitions without `model:` inherit the parent. Search, inventory and log agents should
  name a cheaper model.
- The reverse also counts: a skill that does architecture or adversarial review pinned to haiku is
  an effectiveness finding.

## 4. Determinism
If a skill's instructions walk the model through a fixed procedure (parse this file, compute that
date, call these three commands in order), the procedure belongs in a script. The model then runs
it and handles only judgment and exceptions. Watch for:
- long numbered step lists made of shell commands
- the same helper logic copied across several commands
- instructions that say "carefully" or "always" about something a script could just enforce
- logic a hook could enforce instead of a sentence in CLAUDE.md ("never edit generated files")

## 5. Triggering
- Undertriggering: the description says what the skill *is* but not the phrases or situations that
  should pull it in.
- Overtriggering and collisions: two skills whose descriptions claim the same phrases. The
  inventory's "same name in more than one place" table and a skim of descriptions find these.
- Commands without frontmatter have no description, so the model can't pick them and `/help` shows
  nothing useful.

## 6. Duplication and drift
- The same rule stated in CLAUDE.md, a skill, and a command will drift. Pick one home and point at
  it from the others.
- Repo and user layers defining the same skill or command name: confirm which one wins and whether
  the loser is dead.
- Settings split across `settings.json` and `settings.local.json`: team-relevant permissions
  committed only to the local file mean teammates hit prompts you never see.

## 7. Dead weight
- Commands, skills, agents and MCP servers that never show up in the usage report. That report
  only covers the window it read, so say how long the window was. Before calling a repo artifact
  dead, check `git log` for recent edits: a file changed last week is in use even if this window
  missed it. Plugins and MCP servers with zero calls are the cheapest wins, because disabling them
  is one line.
- Backup and trash directories under `.claude/`.
- Hooks pointing at scripts that no longer exist (check that each hook command's path resolves).

## 8. Permissions friction
- A large `allow` list made of one-off exact commands (`Bash(git log --oneline -5)`) is accreted
  approvals. A few prefix rules usually replace dozens of entries.
- Prompts the user keeps approving belong in `allow`. Dangerous patterns missing from `deny` are
  a safety finding; report them, and leave changing them to the user.

## 9. Maintainability
- Skills over ~500 lines with no `references/` split.
- Scripts with no usage line, hardcoded absolute user paths in a shared/committed repo, or platform
  assumptions (PowerShell-only, macOS-only) in a cross-platform team.
- Hook commands with inline multi-line shell that would be clearer as a script file.

## 10. Changelog cross-reference
For each release in the slice, sort the entries into:
- **Adopt:** a new capability that replaces something custom in the inventory (a hook, a script, a
  workaround, a long instruction). This is the most valuable category. Name the artifact it
  replaces.
- **Unblock:** a bug fix that makes an existing workaround unnecessary. Find the workaround (often
  a comment like "work around", "because Claude Code", "bug").
- **Act:** a deprecation, rename or behavior change that affects something in the inventory.
- **Irrelevant:** everything else. Don't list these. Give a count.

Most releases are mostly fixes, and an "Irrelevant" count of 90% is normal. Don't stretch an entry
to make it look relevant.

## 11. Outside the .claude folder
- **CI workflows that call Claude** (the inventory lists them with triggers and pinned models).
  Look for overlap with in-session pipelines: a CI review that re-reviews PRs an in-session
  `/review` loop already covers is paid for twice on every push. Also check for models pinned to
  old versions.
- **Worktrees.** The inventory shows their count and disk use. Tens of GB of stale worktrees
  slow down tools that walk the tree and fill the disk. Recommend a cleanup pass, and if the repo
  makes many worktrees, an automatic one.
