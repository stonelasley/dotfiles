#!/usr/bin/env python3
"""One call that gathers everything the audit needs and prints a compact digest.

Runs inventory.py, usage.py and changelog.sh, saves their full output to a work dir, and prints
only what a model needs to start judging: versions, headline costs, rule-based suspects with
evidence, a usage summary, and the changelog entries that touch this setup's surfaces.
Full tables stay on disk for targeted `rg` lookups. Keep the digest small: every char printed here
is re-read on every later turn of the audit.

usage: gather.py [repo_root] [--repo-only] [--sessions N] [--releases N | --since V | --installed]
"""
import json
import os
import re
import subprocess
import sys
from datetime import date
from pathlib import Path

sys.path.insert(0, str(Path(__file__).resolve().parent))
import jev  # noqa: E402

HERE = Path(__file__).resolve().parent
HOME = Path.home()

# Changelog surfaces that never touch a repo's Claude config. Dropped from the digest, counted.
NOISE = {
    "IDE": r"VS ?Code|JetBrains|\bIDE\b",
    "desktop/remote/cloud": r"desktop app|Remote Control|cloud session|Cowork|claude\.ai/code|remote-env|web app",
    "Slack/Tag": r"Claude Tag|Slack",
    "mods/plugin engine": r"\bmods?\b|\$\.|hooks worker|hooks module|plugin interface|claude plugin (validate|test)",
    "providers/gateway": r"Bedrock|Vertex|Foundry|gateway|proxy|NO_PROXY|HTTPS_PROXY",
    "TUI/input": r"vim mode|fullscreen|iTerm2|scrollback|paste|cursor|theme|screen reader|keybinding|Ctrl\+|footer",
    "misc product": r"/bug|/share|/feedback|ultrareview|usage limit alert|OpenTelemetry|OTel",
}
# Surfaces a repo setup can use. An entry must hit one of these to be shown.
SIGNAL = r"(?i)hook|skill|slash command|command file|frontmatter|allowed-tools|subagent|Agent tool|agent definition|" \
         r"/loop|schedul|wakeup|background|worktree|MCP|permission|settings|CLAUDE\.md|rules|plugin|" \
         r"\bmodel\b|haiku|sonnet|opus|fable|effort|compact|statusline|status line|-p\b|headless|SDK|workflow|" \
         r"env(ironment)? var|CLAUDE_CODE_|cache|token|cost|Bash tool|Read tool|Write|Edit"


def run(cmd, cwd):
    return subprocess.run(cmd, cwd=cwd, capture_output=True, text=True).stdout


def git_root(arg):
    if arg:
        return Path(arg).resolve()
    out = subprocess.run(["git", "rev-parse", "--show-toplevel"], capture_output=True, text=True).stdout.strip()
    return Path(out or os.getcwd())


def load(p):
    try:
        return json.loads(Path(p).read_text())
    except Exception:
        return None


def main():
    argv = sys.argv[1:]
    pos = [a for i, a in enumerate(argv) if not a.startswith("--") and (i == 0 or argv[i - 1] not in
                                                                        ("--sessions", "--releases", "--since"))]
    root = git_root(pos[0] if pos else None)
    repo_only = "--repo-only" in argv
    sessions = argv[argv.index("--sessions") + 1] if "--sessions" in argv else "50"
    if "--since" in argv:
        cl_args = ["--since", argv[argv.index("--since") + 1]]
    elif "--installed" in argv:
        cl_args = ["--installed"]
    else:
        cl_args = [argv[argv.index("--releases") + 1] if "--releases" in argv else "1"]

    out = Path(os.environ.get("TMPDIR", "/tmp")) / "claude-audit" / f"{root.name}-{date.today()}"
    out.mkdir(parents=True, exist_ok=True)
    flags = ["--repo-only"] if repo_only else []

    inv = json.loads(run([sys.executable, HERE / "inventory.py", str(root), "--json", *flags], root))
    (out / "inventory.md").write_text(run([sys.executable, HERE / "inventory.py", str(root), *flags], root))
    use = json.loads(run([sys.executable, HERE / "usage.py", str(root), "--sessions", sessions, "--json"], root) or "{}") \
        if "no transcripts" not in run([sys.executable, HERE / "usage.py", str(root), "--sessions", "1"], root) else {}
    if use:
        (out / "usage.md").write_text(run([sys.executable, HERE / "usage.py", str(root), "--sessions", sessions], root))
    cl = run(["bash", HERE / "changelog.sh", *cl_args], root)
    (out / "changelog.md").write_text(cl)

    P = []  # (severity, lens, text)

    def s(sev, lens, text):
        P.append((sev, lens, text))

    # --- hooks
    hooks = inv["hooks"]
    errs = use.get("hook_errors", [])
    src_broken = sum(1 for h in hooks if h["layer"] == "repo-src" and h["resolves"].startswith("BROKEN"))
    for h in hooks:
        if h["layer"] == "repo-src":
            continue
        tag = f'{h["layer"]}:{h["settings"]} {h["event"]}[{h["matcher"] or "*"}]'
        if h["resolves"].startswith("BROKEN"):
            n = sum(e["sessions"] for e in errs if e["key"].startswith(h["event"]) and
                    any(w in e["key"] for w in re.findall(r"`([^`]+)`|missing (\S+)", h["resolves"])[0] if w))
            live = "" if h["layer"] != "repo-src" else " (repo-src file: only matters if it's loaded/linked)"
            s(3 if h["layer"] != "repo-src" else 1, "broken hook",
              f'{tag}: {h["resolves"]}; failed in {n}/{use.get("sessions", "?")} sessions{live} :: `{h["command"][:90]}`')
        if h["env_vars"] and h["layer"] != "repo-src":
            s(2, "hook input", f'{tag} relies on ${h["env_vars"]} (verify the harness sets it; payload is stdin JSON) :: `{h["command"][:90]}`')
        if re.match(r"^(bash|sh|node|bun|python3?)?\s*\./", h["command"]) and h["layer"] == "repo":
            s(2, "hook input", f'{tag} uses a relative script path; breaks when cwd moves. Use "$CLAUDE_PROJECT_DIR"/... :: `{h["command"][:90]}`')
    for e in sorted(errs, key=lambda e: -e["sessions"])[:6]:
        broken_tokens = [w for h in hooks if h["resolves"].startswith("BROKEN")
                         for w in re.findall(r"`([^`]+)`|missing (\S+)", h["resolves"])[0] if w]
        if not any(w in e["key"] for w in broken_tokens):
            s(2, "hook errors", f'{e["key"][:150]} — {e["count"]}x in {e["sessions"]}/{use["sessions"]} sessions')
    live_hooks = [h for h in hooks if h["layer"] != "repo-src" and h["type"] == "command" and not h["async"]]
    for ev in ("PreToolUse", "PostToolUse"):
        catch = [h for h in live_hooks if h["event"] == ev and h["matcher"] in ("", "*")]
        if len(catch) >= 2:
            s(2, "per-call cost", f'{len(catch)} blocking catch-all {ev} hooks run on EVERY tool call: ' +
              ", ".join(Path(h["command"].split()[0]).name for h in catch))
    by_cmd = {}
    for h in live_hooks:
        by_cmd.setdefault((h["event"], h["command"]), []).append(h["matcher"])
    for (ev, cmd), ms in by_cmd.items():
        if len(ms) > 1:
            s(1, "per-call cost", f'{ev} `{cmd[:70]}` registered {len(ms)}x ({", ".join(ms)}); fold into one `A|B` matcher')
    for inj in sorted(use.get("inject", []), key=lambda x: -x["avg_chars"] * x["fires"])[:3]:
        if inj["avg_chars"] > 500:
            s(1, "always-on cost", f'hook {inj["hook"]} injects ~{inj["avg_chars"] // 4} tok avg, fired {inj["fires"]}x in {inj["sessions"]} sessions')

    # --- CLAUDE.md
    for m in inv["claude_md"]:
        nested = Path(m["path"]).parent not in (root, HOME / ".claude")
        if (nested and m["lines"] >= 400) or (not nested and m["lines"] >= 200):
            s(2 if m["tok"] > 6000 else 1, "always-on cost",
              f'{m["path"].replace(str(root) + "/", "")}: {m["lines"]} lines ≈{m["tok"]} tok ({"nested" if nested else "loaded every session"})')

    # --- skills / commands
    for k in inv["skills"]:
        if k["layer"] == "user":
            continue
        if k["desc_chars"] > 1000:
            s(1, "triggering", f'skill {k["name"]} description {k["desc_chars"]} chars (body content in the listing?)')
        if k["body_lines"] > 500 and not k["has_refs"]:
            s(1, "maintainability", f'skill {k["name"]} is {k["body_lines"]} lines with no references/')
    for c in inv["commands"]:
        if c["layer"] == "user":
            continue
        if not c["has_frontmatter"]:
            s(1, "triggering", f'command {c["name"]} has no frontmatter (no description, model, allowed-tools) :: {c["path"]}')
        try:
            body = Path(c["path"]).read_text(errors="replace")
        except OSError:
            continue
        hit = re.search(r"(?i)run[^.\n]{0,30}\bon (sonnet|haiku|opus)\b", body)
        if hit and not c["model"]:
            line = body[:hit.start()].count("\n") + 1
            s(2, "model routing", f'{c["path"].replace(str(root) + "/", "")}:{line} says "{hit.group(0)}" in prose; no `model:` frontmatter')
    models = use.get("models", {})
    if models:
        s(0, "model routing", "main-session turns: " + ", ".join(f"{k} {v}" for k, v in sorted(models.items(), key=lambda x: -x[1])))

    # --- repo-src (dotfiles-style claude/ dir)
    for layer, base in inv["layers"]:
        if layer != "repo-src":
            continue
        if (Path(base) / "settings.json").exists():
            s(2, "dead weight", f'{base}/settings.json is NOT read by Claude Code (only .claude/settings*.json are); '
                                f'dead unless something links it. {src_broken} of its hooks point at missing scripts')
        for d in sorted((Path(base) / "skills").glob("*/SKILL.md")):
            if not (HOME / ".claude" / "skills" / d.parent.name).exists():
                s(2, "drift", f'skill {d.parent.name} in {base}/skills is not linked into ~/.claude/skills (installer not re-run?)')

    # --- plugins + MCP vs usage
    enabled = {}
    for st in inv["settings"]:
        for p in st.get("enabledPlugins", []):
            enabled[p.split("@")[0]] = st["layer"]
    skill_calls = use.get("skills", {})
    mcp_calls = use.get("mcp", {})
    per_plugin = {}
    for ps in inv["plugin_skills"]:
        parts = ps["path"].split("/")
        plug = parts[1] if len(parts) > 1 else parts[0]
        per_plugin.setdefault(plug, {})[ps["name"]] = ps["desc_chars"]
    for plug, layer in enabled.items():
        used = sum(v for k, v in skill_calls.items() if k.startswith(plug + ":")) + \
               sum(v for k, v in mcp_calls.items() if plug in k)
        tok = sum(per_plugin.get(plug, {}).values()) // 4
        if use and used == 0 and tok > 300:
            s(2, "always-on cost", f'plugin {plug} ({layer}) enabled, 0 skill/MCP calls in {use["sessions"]} sessions, '
                                   f'~{tok} tok of skill descriptions ({len(per_plugin.get(plug, {}))} skills)')
    seen = {}
    for m in inv["mcp"]:
        seen.setdefault(m["command"], []).append(f'{m["name"]}@{m["source"]}')
        if use and not any(m["name"] in k for k in mcp_calls):
            s(1, "dead weight", f'MCP server {m["name"]} ({m["source"]}) had 0 calls in {use["sessions"]} sessions')
    for cmd, where in seen.items():
        if len(where) > 1 and cmd:
            s(1, "duplication", f'same MCP command declared {len(where)}x: {", ".join(where)}')

    # --- permissions
    mcp_names = {m["name"] for m in inv["mcp"]} | set(enabled)
    for layer, base in inv["layers"]:
        for name in ("settings.json", "settings.local.json"):
            d = load(Path(base) / name)
            if not isinstance(d, dict) or layer == "repo-src":
                continue
            allow = (d.get("permissions") or {}).get("allow") or []
            if layer == "user":
                continue
            broad = [a for a in allow if a in ("Bash", "Bash(*)", "Bash(bash:*)", "Bash(sh:*)", "Bash(git:*)", "Bash(curl:*)",
                                               "Bash(python3:*)", "Bash(node:*)", "mcp__*", 'Bash(python3 -c ":*)')]
            frags = [a for a in allow if re.match(r"Bash\((done|fi|do\b|then\b|else\b|set -e)", a)]
            dead_mcp = sorted({a.split("__")[1] for a in allow if a.startswith("mcp__") and
                               not any(n.replace("-", "") in a.replace("-", "") for n in mcp_names)})
            long = [a for a in allow if len(a) > 120]
            if len(allow) > 40 or broad or frags or dead_mcp:
                s(1 if not broad else 2, "permissions",
                  f'{base}/{name}: {len(allow)} allow rules; broad: {broad or "none"}; shell fragments: {len(frags)}; '
                  f'one-off >120 chars: {len(long)}; rules for unconfigured MCP servers: {dead_mcp or "none"}')

    # --- CI / worktrees
    gh = root / ".github" / "workflows"
    for c in inv["ci"]:
        t = (root / c["file"]).read_text(errors="replace")
        for u in re.findall(r"uses:\s*([\w.-]+/[\w./-]+)@(main|master|HEAD)\b", t):
            if not u[0].startswith(("actions/", "anthropics/")) and "secrets." in t:
                s(3, "safety", f'{c["file"]} runs third-party `{u[0]}@{u[1]}` (unpinned) with secrets')
        if c["models"]:
            s(1, "CI", f'{c["file"]} pins {c["models"]} (triggers: {c["triggers"]}) — check vs current models and overlap with in-session review loops')
        elif c["triggers"]:
            s(0, "CI", f'{c["file"]} calls Claude on: {c["triggers"]}')
    for w in inv["worktrees"]:
        if w["trees"] >= 5 or "GB" in w["size"]:
            s(2, "disk", f'{w["dir"]}: {w["trees"]} worktrees, {w["size"]}')

    # --- changelog
    head, _, body = cl.partition("\n## ")
    body = "## " + body if body else ""
    entries, release = [], ""
    for line in body.splitlines():
        if line.startswith("## "):
            release = line[3:].strip()
        elif line.startswith("- "):
            entries.append((release, line[2:]))
    noise_counts, keep = {}, []
    for rel, e in entries:
        bucket = next((b for b, rx in NOISE.items() if re.search(rx, e)), None)
        if bucket:
            noise_counts[bucket] = noise_counts.get(bucket, 0) + 1
        elif re.search(SIGNAL, e):
            keep.append((rel, e))
        else:
            noise_counts["no config surface"] = noise_counts.get("no config surface", 0) + 1
    if not (root.glob("*.ps1") and any(root.rglob("*.ps1"))):
        win = [k for k in keep if re.search(r"\bWindows\b|PowerShell", k[1])]
        keep = [k for k in keep if k not in win]
        noise_counts["Windows (no .ps1 in repo)"] = len(win)

    # Rank what's left: new capabilities first, then entries naming something this setup has.
    vocab = {h["event"] for h in hooks} | {m["name"] for m in inv["mcp"]} | set(enabled)
    vocab |= {"skill", "frontmatter", "permission", "CLAUDE.md", "settings", "subagent", "Agent tool", "effort", "hook"}
    if any(re.search(r"loop|ScheduleWakeup", json.dumps(use.get("commands", {}))) for _ in [0]) or \
            any("loop" in Path(c["path"]).read_text(errors="replace")[:4000] for c in inv["commands"] if c["layer"] == "repo"):
        vocab |= {"/loop", "scheduled", "wakeup", "background"}
    if inv["worktrees"]:
        vocab.add("worktree")
    if inv["ci"]:
        vocab |= {"claude -p", "headless", "GitHub Action"}

    FEATURE = r"(Added|Changed|Deprecated|Removed|Improved|Renamed|Security)"

    def score(e):
        return sum(2 for v in vocab if v.lower() in e.lower()) + (5 if re.search(r"(Haiku|Sonnet|Opus|Fable) \d", e) else 0)
    # Keyword scores can't judge relevance, so never cap away a new capability: every
    # Added/Changed/... entry is shown (trimmed), and only fixes are ranked and capped.
    features = [k for k in keep if re.match(FEATURE, k[1])]
    fixes = sorted((k for k in keep if not re.match(FEATURE, k[1])), key=lambda k: -score(k[1]))
    fix_cap = 20
    shown = features + [k for k in fixes[:fix_cap] if score(k[1]) > 0]
    rest = [k for k in fixes if k not in shown]
    (out / "changelog-ranked.md").write_text("\n".join(f"- [{score(e)}] {r}: {e}" for r, e in features + fixes))

    # --- Jev: changelog triage against a profile of this setup (keyword ranking is the fallback)
    jev_note = "jev: unavailable (no TYPESAFE_API_KEY); keyword filter used"
    loops = any("/loop" in Path(c["path"]).read_text(errors="replace") for c in inv["commands"] + inv["skills"]
                if c["layer"] != "user")
    profile = {
        "platform": sys.platform, "installed_cli": re.search(r"installed:\s+(\S+)", head).group(1) if "installed:" in head else "?",
        "hook_events_used": sorted({h["event"] for h in live_hooks}),
        "hook_types": sorted({h["type"] for h in hooks if h["layer"] != "repo-src"}),
        "repo_skills": [k["name"] for k in inv["skills"] if k["layer"] != "user"][:30],
        "repo_commands": [c["name"] for c in inv["commands"] if c["layer"] != "user"][:40],
        "subagents_dispatched": bool(use.get("agents")), "custom_agent_definitions": len(inv["agents"]),
        "uses_loop_and_scheduled_tasks": loops, "git_worktrees": bool(inv["worktrees"]),
        "ci_workflows_calling_claude": [c["file"] for c in inv["ci"]],
        "mcp_servers": [f'{m["name"]} ({m["type"]})' for m in inv["mcp"]], "plugins_enabled": sorted(enabled),
        "models_used": sorted(use.get("models", {})), "permission_rules": "allow/ask lists in settings",
        "not_used": "VS Code/JetBrains, desktop app, cloud/remote sessions, Claude Tag/Slack, authoring mods or plugin "
                    "hook engines, Bedrock/Vertex/gateways" + ("" if sys.platform.startswith("win") else ", Windows"),
    }
    # Deterministic noise filter first (free, and Jev over-credits mods/plugin-engine notes),
    # then Jev judges only what's left.
    jev_entries = [(r, e) for r, e in entries if not any(re.search(rx, e) for rx in NOISE.values())]
    if jev.available() and jev_entries:
        crit = {"adopt": "A new capability, setting or model this setup could start using to replace custom tooling, cut cost, go faster, or get better results",
                "unblock": "A bug fix in a feature this setup actually uses (see the profile); upgrading removes a failure or a workaround",
                "act": "A behavior, default or naming change that could break or alter something this setup uses, so it needs checking",
                "irrelevant": "About something this setup doesn't use, or cosmetic UI polish with no config impact"}
        qs = {}
        for i, (rel, e) in enumerate(jev_entries):
            qs[f"c{i}"] = {"type": "choice", "criteria": crit,
                           "instructions": {"release_note": e, "question": "How does `release_note` relate to the Claude Code setup in the state?"}}
            qs[f"u{i}"] = {"type": "noul", "instructions": {"release_note": e,
                           "question": "Does `release_note` name a specific feature, hook event, file or tool that appears in the state's profile?"}}
        try:
            a = jev.ask_many(profile, qs)
            tri = []
            for i, (rel, e) in enumerate(jev_entries):
                c, u = a[f"c{i}"], a[f"u{i}"]["noul"]
                rel_p = 1 - c["probabilities"]["irrelevant"]
                tri.append((c["choice"], rel_p * (0.5 + u / 2), rel, e, c["probabilities"]))
            # Jev ranks; it doesn't gate new capabilities. Every Added/Changed/... entry stays unless
            # Jev is near-certain it's irrelevant (it once labelled the `verify`-skill note "act").
            feats = sorted([t for t in tri if re.match(FEATURE, t[3]) and t[4]["irrelevant"] < 0.9], key=lambda t: -t[1])
            fixes_j = sorted([t for t in tri if not re.match(FEATURE, t[3]) and t[0] in ("unblock", "act")], key=lambda t: -t[1])
            shown_j = {"new or changed (all kept unless Jev is ≥0.9 sure it's irrelevant)": feats,
                       "fixes Jev ranks as hitting this setup (top 15)": [t for t in fixes_j if t[1] >= 0.35][:15]}
            (out / "changelog-jev.md").write_text("\n".join(
                f"- {t[0]} {t[1]:.2f} {t[2]}: {t[3]}" for t in sorted(tri, key=lambda t: -t[1])))
            jev_note = jev.cost_line()
        except Exception as ex:  # network / quota: fall back silently to the keyword view
            shown_j = None
            jev_note = f"jev: failed ({type(ex).__name__}); keyword filter used"
    else:
        shown_j = None

    # --- Jev: file triage, so the model opens only files likely to hold a finding
    file_hits = []
    if jev.available():
        files = [(c["path"], "command") for c in inv["commands"] if c["layer"] == "repo"] + \
                [(k["path"], "skill") for k in inv["skills"] if k["layer"] == "repo"] + \
                [(m["path"], "claude_md") for m in inv["claude_md"] if m["lines"] >= 150 and Path(m["path"]).parent != HOME / ".claude"]
        FQ = {
            "procedure": ("noul", "Is most of this text literal shell commands to run in a fixed order, with little judgment needed between them, so a script could replace the instructions?"),
            "model_prose": ("noul", "Does this text tell the reader to run it on a particular model or effort level in prose, instead of that being set in configuration?"),
            "reference_heavy": ("noul", "Is most of this text how-to reference material (long procedures, examples, history) rather than short rules that must apply on every task?"),
            "contradiction": ("noul", "Does this text contain instructions that contradict each other?"),
        }
        items = []
        for path, kind in files:
            try:
                txt = Path(path).read_text(errors="replace")[:90_000]
            except OSError:
                continue
            items.append((path, kind, txt))
        try:
            answers = jev.ask_each([({"kind": kind, "path": Path(path).name, "text": txt},
                                     {k: {"type": t, "instructions": q} for k, (t, q) in FQ.items()})
                                    for path, kind, txt in items])
            for (path, kind, _), ans in zip(items, answers):
                for k, v in ans.items():
                    if v["noul"] >= (0.9 if k == "procedure" else 0.8) and not (k == "reference_heavy" and kind == "skill"):
                        file_hits.append((v["noul"], k, path.replace(str(root) + "/", "")))
            jev_note = jev.cost_line()
        except Exception as ex:
            jev_note += f"; file triage failed ({type(ex).__name__})"

    # --- print digest
    print(f"# claude-audit digest: {root}")
    print(f"full data: {out}/{{inventory,usage,changelog}}.md  (rg there; don't cat whole files)\n")
    print(head.strip())
    print(f"\nlayers: {', '.join(l for l, _ in inv['layers'])} · listing ≈{inv['listing_tok']} tok · "
          f"skills {len(inv['skills'])} · commands {len(inv['commands'])} · agents {len(inv['agents'])} · "
          f"hooks {len(hooks)} · MCP {len(inv['mcp'])} · plugins enabled {len(enabled)}")
    if use:
        print(f"usage window: {use['sessions']} sessions {str(use['first'])[:10]} → {str(use['last'])[:10]}")
        top = lambda d, n=10: ", ".join(f"{k} {v}" for k, v in sorted(d.items(), key=lambda x: -x[1])[:n]) or "none"
        print(f"  commands: {top(use['commands'])}\n  skills: {top(use['skills'])}\n  agents: {top(use['agents'], 5)}\n  mcp: {top(use['mcp'])}")
    else:
        print("usage: no local transcripts for this repo")
    print("\n## Suspects (rule-based; confirm before reporting, and look beyond them)")
    for sev, lens, text in sorted(P, key=lambda x: -x[0]):
        print(f"- [{'!' * sev or '·'}] {lens}: {text}")
    if file_hits:
        print("\n## Files Jev flags as worth opening (p ≥ 0.8; a lead, not a finding)")
        for p_, k, path in sorted(file_hits, reverse=True)[:12]:
            print(f"- {k} {p_:.2f}: {path}")
    print(f"\n{jev_note}")
    if shown_j is not None:
        n_irr = len(jev_entries) - sum(len(v) for v in shown_j.values())
        print(f"\n## Changelog triaged by Jev ({len(entries)} entries; {len(entries) - len(jev_entries)} dropped by noise filter; "
              f"{n_irr} judged irrelevant or low-relevance; "
              f"all scored in {out}/changelog-jev.md)")
        for k, rows in shown_j.items():
            print(f"### {k}: {len(rows)}")
            trim_j = 220 if len(rows) <= 30 else 140
            for lab, sc, rel, e, _ in rows:
                print(f"- {lab} {sc:.2f} {rel}: {e[:trim_j]}{'…' if len(e) > trim_j else ''}")
        return
    print(f"\n## Changelog: {len(features)} new/changed + top {len(shown) - len(features)} fixes of {len(keep)} config-surface entries ({len(entries)} total; "
          f"dropped: {', '.join(f'{k} {v}' for k, v in noise_counts.items() if v)})")
    trim = 260 if len(shown) <= 40 else 140
    for rel, e in shown:
        print(f"- {rel}: {e[:trim]}{'…' if len(e) > trim else ''}")
    if rest:
        print(f"\n{len(rest)} lower-ranked entries in {out}/changelog-ranked.md (score in brackets). rg it for any surface you're unsure about.")


if __name__ == "__main__":
    main()
