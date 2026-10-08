#!/usr/bin/env python3
"""Inventory every Claude Code artifact that shapes a session in this repo.

Covers the repo (.claude/, CLAUDE.md files, .mcp.json) and, unless --repo-only,
the user layer (~/.claude). Emits Markdown tables a model can read in one pass:
what exists, how big it is (≈ tokens), and the frontmatter/config that matters
for cost and triggering. It makes no judgments; the skill does that.

usage: inventory.py [repo_root] [--repo-only] [--json]
"""
import json
import os
import re
import shlex
import shutil
import subprocess
import sys
from pathlib import Path

HOME = Path.home()
SKIP_DIRS = {"node_modules", ".git", "worktrees", "bin", "obj", "dist", ".venv", "cache", ".trash", "_backups", "backups"}


def toks(n_bytes):
    return round(n_bytes / 4)


def frontmatter(path):
    try:
        text = path.read_text(errors="replace")
    except OSError:
        return {}, 0, 0
    lines = text.count("\n") + 1
    fm = {}
    m = re.match(r"^---\n(.*?)\n---\n", text, re.S)
    if m:
        key = None
        for line in m.group(1).splitlines():
            km = re.match(r"^([A-Za-z0-9_-]+):\s*(.*)$", line)
            if km:
                key, val = km.group(1), km.group(2).strip()
                fm[key] = val
            elif key and line.startswith((" ", "\t")):
                fm[key] = (fm[key] + " " + line.strip()).strip()
    return fm, len(text.encode()), lines


def repo_root(arg):
    if arg:
        return Path(arg).resolve()
    try:
        out = subprocess.run(["git", "rev-parse", "--show-toplevel"], capture_output=True, text=True, check=True)
        return Path(out.stdout.strip())
    except Exception:
        return Path.cwd()


def walk(base, pattern):
    if not base.exists():
        return []
    out = []
    for p in sorted(base.rglob(pattern)):
        if any(part in SKIP_DIRS for part in p.relative_to(base).parts):
            continue
        out.append(p)
    return out


def dir_bytes(d):
    total = 0
    for p in d.rglob("*"):
        if p.is_file() and not any(part in SKIP_DIRS for part in p.relative_to(d).parts):
            try:
                total += p.stat().st_size
            except OSError:
                pass
    return total


def skills(base, layer):
    rows = []
    for sk in walk(base, "SKILL.md"):
        fm, b, lines = frontmatter(sk)
        d = sk.parent
        rows.append({
            "layer": layer, "name": fm.get("name", d.name), "path": str(sk),
            "desc_chars": len(fm.get("description", "")), "body_lines": lines,
            "body_tok": toks(b), "dir_tok": toks(dir_bytes(d)),
            "model": fm.get("model", ""), "effort": fm.get("effort", ""),
            "allowed_tools": fm.get("allowed-tools", ""),
            "model_invocation": "off" if fm.get("disable-model-invocation", "").lower() == "true" else "on",
            "has_scripts": (d / "scripts").exists(), "has_refs": (d / "references").exists(),
        })
    return rows


def commands(base, layer):
    rows = []
    for c in walk(base, "*.md"):
        fm, b, lines = frontmatter(c)
        rows.append({
            "layer": layer, "name": c.relative_to(base).with_suffix("").as_posix().replace("/", ":"),
            "path": str(c), "desc_chars": len(fm.get("description", "")), "lines": lines, "tok": toks(b),
            "model": fm.get("model", ""), "allowed_tools": fm.get("allowed-tools", ""),
            "has_frontmatter": bool(fm),
        })
    return rows


def agents(base, layer):
    rows = []
    for a in walk(base, "*.md"):
        fm, b, lines = frontmatter(a)
        rows.append({
            "layer": layer, "name": fm.get("name", a.stem), "path": str(a),
            "desc_chars": len(fm.get("description", "")), "tok": toks(b),
            "model": fm.get("model", ""), "tools": fm.get("tools", ""),
        })
    return rows


def load_json(p):
    try:
        return json.loads(p.read_text())
    except Exception as e:
        return {"__error__": str(e)} if p.exists() else None


KNOWN_VARS = {"HOME", "CLAUDE_PROJECT_DIR", "CLAUDE_PLUGIN_ROOT", "PWD", "USER", "PATH"}


def hook_check(cmd, root):
    """Does the hook's interpreter and script exist here? Which env vars does it lean on?"""
    if not cmd:
        return "", ""
    env = sorted(set(re.findall(r"\$\{?([A-Z_][A-Za-z0-9_]*)", cmd)) - KNOWN_VARS)
    expanded = cmd.replace("${CLAUDE_PROJECT_DIR}", str(root)).replace("$CLAUDE_PROJECT_DIR", str(root))
    expanded = os.path.expandvars(os.path.expanduser(expanded))
    try:
        parts = shlex.split(expanded)
    except ValueError:
        return "unparsed", " ".join(env)
    if not parts or parts[0] in ("if", "[", "test", "case", "for"):
        return "shell logic", " ".join(env)
    problems = []
    first = parts[0]
    if "/" in first:
        if not (root / first).exists() and not Path(first).exists():
            problems.append(f"missing {first}")
    elif not shutil.which(first):
        problems.append(f"no `{first}` on PATH")
    for tok in parts[1:]:
        if re.search(r"\.(sh|ps1|ts|js|mjs|cjs|py)$", tok) and not tok.startswith("-"):
            if not (root / tok).exists() and not Path(tok).exists():
                problems.append(f"missing {tok}")
            break
    return ("BROKEN: " + "; ".join(problems)) if problems else "ok", " ".join(env)


def settings_summary(p, layer, root):
    d = load_json(p)
    if d is None:
        return None, []
    if "__error__" in d:
        return {"layer": layer, "path": str(p), "error": d["__error__"]}, []
    perms = d.get("permissions", {}) or {}
    summary = {
        "layer": layer, "path": str(p), "keys": sorted(d.keys()),
        "allow": len(perms.get("allow", []) or []), "deny": len(perms.get("deny", []) or []),
        "ask": len(perms.get("ask", []) or []), "defaultMode": perms.get("defaultMode", ""),
        "model": d.get("model", ""), "env": sorted((d.get("env") or {}).keys()),
        "enabledPlugins": sorted(k for k, v in (d.get("enabledPlugins") or {}).items() if v),
        "skillOverrides": len(d.get("skillOverrides") or {}),
    }
    hooks = []
    for event, groups in (d.get("hooks") or {}).items():
        for g in groups or []:
            for h in g.get("hooks", []) or []:
                resolves, env = hook_check(h.get("command") if h.get("type") == "command" else "", root)
                hooks.append({"resolves": resolves, "env_vars": env,
                    "layer": layer, "settings": p.name, "event": event, "matcher": g.get("matcher", ""),
                    "type": h.get("type", ""), "timeout": h.get("timeout", ""),
                    "async": h.get("async", ""),
                    "command": (h.get("command") or h.get("prompt") or h.get("url") or "")[:160],
                })
    return summary, hooks


def tracked(root, names):
    """Files the repo itself owns: git-tracked (skips submodules/vendored trees), plus untracked local ones."""
    try:
        out = subprocess.run(["git", "-C", str(root), "ls-files", "--cached", "--others", "--exclude-standard"],
                             capture_output=True, text=True, check=True).stdout.splitlines()
        return [root / f for f in out if Path(f).name in names]
    except Exception:
        return [p for n in names for p in walk(root, n)]


def claude_mds(root, include_user):
    files = sorted(tracked(root, {"CLAUDE.md", "CLAUDE.local.md", "AGENTS.md"}))
    if include_user and (HOME / ".claude" / "CLAUDE.md").exists():
        files.append(HOME / ".claude" / "CLAUDE.md")
    rows = []
    for f in files:
        text = f.read_text(errors="replace")
        imports = re.findall(r"^@(\S+)", text, re.M)
        imp_tok = 0
        for i in imports:
            ip = (f.parent / os.path.expanduser(i)) if not i.startswith(("/", "~")) else Path(os.path.expanduser(i))
            if not ip.exists():
                ip = HOME / ".claude" / i
            if ip.exists():
                imp_tok += toks(ip.stat().st_size)
        rows.append({"path": str(f), "lines": text.count("\n") + 1, "tok": toks(len(text.encode())),
                     "imports": len(imports), "import_tok": imp_tok})
    return rows


def table(title, rows, cols):
    if not rows:
        return f"## {title}\n\n(none)\n"
    out = [f"## {title} ({len(rows)})", "", "| " + " | ".join(cols) + " |", "|" + "---|" * len(cols)]
    for r in rows:
        out.append("| " + " | ".join(str(r.get(c, "")).replace("|", "\\|") for c in cols) + " |")
    return "\n".join(out) + "\n"


def main():
    args = [a for a in sys.argv[1:] if not a.startswith("--")]
    repo_only = "--repo-only" in sys.argv
    root = repo_root(args[0] if args else None)
    rc = root / ".claude"
    uc = HOME / ".claude"
    layers = [("repo", rc)]
    # Some repos (dotfiles) keep Claude config in a plain `claude/` dir that gets linked into ~/.claude.
    for alt in sorted(root.glob("*/")) + [root / "claude"]:
        if alt.name in ("claude", "dot-claude", "claude-config") and alt != rc and alt.is_dir() \
                and any((alt / x).exists() for x in ("skills", "commands", "agents", "settings.json")) \
                and ("repo-src", alt) not in layers:
            layers.append(("repo-src", alt))
    if not repo_only and rc != uc:
        layers.append(("user", uc))

    sk, cm, ag, hk, st = [], [], [], [], []
    for layer, base in layers:
        sk += skills(base / "skills", layer)
        cm += commands(base / "commands", layer)
        ag += agents(base / "agents", layer)
        for name in ("settings.json", "settings.local.json"):
            s, h = settings_summary(base / name, layer, root)
            if s:
                st.append(s)
            hk += h

    # Plugin-provided skills/commands are listed by name only: they're third-party, so the
    # audit can recommend disabling them but shouldn't edit them.
    plugin_skills = []
    if not repo_only:
        cache = uc / "plugins" / "cache"
        for p in walk(cache, "SKILL.md"):
            fm, b, _ = frontmatter(p)
            plugin_skills.append({"name": fm.get("name", p.parent.name), "desc_chars": len(fm.get("description", "")),
                                  "path": str(p.relative_to(cache))})

    mcp = []
    for p in [root / ".mcp.json"] + ([] if repo_only else [HOME / ".claude.json"]):
        d = load_json(p)
        if isinstance(d, dict):
            servers = d.get("mcpServers") or {}
            for name, cfg in servers.items():
                mcp.append({"source": p.name, "name": name, "type": cfg.get("type", "stdio"),
                            "command": (cfg.get("command") or cfg.get("url") or "")[:80]})
            proj = (d.get("projects") or {}).get(str(root), {})
            for name, cfg in (proj.get("mcpServers") or {}).items():
                mcp.append({"source": f"{p.name} (project)", "name": name, "type": cfg.get("type", "stdio"),
                            "command": (cfg.get("command") or cfg.get("url") or "")[:80]})

    other = []
    for sub in ("workflows", "scripts", "hooks", "output-styles", "templates"):
        for layer, base in layers:
            d = base / sub
            if d.exists():
                files = [p for p in d.rglob("*") if p.is_file() and not any(x in SKIP_DIRS for x in p.parts)]
                other.append({"layer": layer, "dir": str(d), "files": len(files), "tok": toks(sum(f.stat().st_size for f in files))})

    wt = []
    for d in [rc / "worktrees", root / ".worktrees"]:
        if d.is_dir():
            trees = [x for x in d.iterdir() if x.is_dir()]
            try:
                kb = int(subprocess.run(["du", "-sk", str(d)], capture_output=True, text=True, timeout=30).stdout.split()[0])
                size = f"{kb // 1048576} GB" if kb > 1048576 else f"{kb // 1024} MB"
            except Exception:
                size = "du timed out"
            wt.append({"dir": str(d), "trees": len(trees), "size": size})
    ci = []
    gh = root / ".github" / "workflows"
    if gh.is_dir():
        for y in sorted(gh.glob("*.y*ml")):
            t = y.read_text(errors="replace")
            if re.search(r"claude-code-action|anthropic|claude -p|ANTHROPIC_API_KEY|CLAUDE_CODE_OAUTH", t):
                models = sorted(set(re.findall(r"claude-(?:opus|sonnet|haiku|fable)[a-z0-9.-]*", t)))
                trig = re.search(r"^on:\s*\n((?:\s+.*\n){1,6})", t, re.M)
                ci.append({"file": str(y.relative_to(root)), "models": " ".join(models),
                           "triggers": " ".join(re.findall(r"^\s{2}([a-z_]+):", trig.group(1), re.M)) if trig else ""})

    names = {}
    for r in sk + cm:
        names.setdefault(r["name"].split(":")[-1].lower(), []).append(f'{r["layer"]}:{r["path"]}')
    dupes = [{"name": k, "where": " ; ".join(v)} for k, v in names.items() if len(v) > 1]

    # skillOverrides merge across layers by key; anything not "on" keeps a skill out of the listing.
    overrides = {}
    for layer, base in reversed(layers):
        for name in ("settings.json", "settings.local.json"):
            d = load_json(base / name)
            if isinstance(d, dict):
                overrides.update(d.get("skillOverrides") or {})
    for r in sk:
        ov = overrides.get(r["name"])
        if ov is not None:
            r["override"] = ov
            if ov != "on":
                r["model_invocation"] = f"off ({ov})"
    always_on = sum(r["desc_chars"] for r in sk if r["model_invocation"] == "on") // 4
    always_on += sum(r["desc_chars"] for r in cm) // 4 + sum(r["desc_chars"] for r in ag) // 4
    md = claude_mds(root, not repo_only)


    if "--json" in sys.argv:
        print(json.dumps({"root": str(root), "layers": [[l, str(b)] for l, b in layers], "skills": sk,
                          "commands": cm, "agents": ag, "hooks": hk, "settings": st, "mcp": mcp, "claude_md": md,
                          "other": other, "dupes": dupes, "plugin_skills": plugin_skills, "worktrees": wt,
                          "ci": ci, "listing_tok": always_on}, indent=1))
        return

    print(f"# Claude Code inventory: {root}\n")
    print(f"layers: {', '.join(l for l, _ in layers)}  ·  ≈ tok = bytes/4 (rough)")
    print(f"listing cost (descriptions of model-visible skills + commands + agents, excl. plugins): ≈{always_on} tok")
    start = [r for r in md if Path(r["path"]).parent in (root, HOME / ".claude")]
    print(f"CLAUDE.md + @imports loaded at session start (root + user): ≈{sum(r['tok'] + r['import_tok'] for r in start)} tok")
    print(f"nested CLAUDE.md (loaded when Claude reads files under them): ≈{sum(r['tok'] for r in md if r not in start)} tok across {len(md) - len(start)} files")
    per_event = {}
    for h in hk:
        if h["type"] == "command" and not h["async"]:
            per_event.setdefault(h["event"], {"all": 0, "matched": 0})["all" if h["matcher"] in ("", "*") else "matched"] += 1
    print("sync command hooks per event (catch-all / matcher-scoped): " +
          ", ".join(f"{e} {c['all']}/{c['matched']}" for e, c in sorted(per_event.items())) + "\n")
    print(table("CLAUDE.md / AGENTS.md", md, ["path", "lines", "tok", "imports", "import_tok"]))
    print(table("Settings", st, ["layer", "path", "allow", "deny", "ask", "defaultMode", "model", "env", "enabledPlugins", "skillOverrides", "keys"]))
    print(table("Hooks", hk, ["layer", "settings", "event", "matcher", "type", "timeout", "async", "resolves", "env_vars", "command"]))
    print(table("Skills", sk, ["layer", "name", "desc_chars", "body_lines", "body_tok", "dir_tok", "model", "effort", "model_invocation", "allowed_tools", "has_scripts", "has_refs", "path"]))
    print(table("Commands", cm, ["layer", "name", "has_frontmatter", "desc_chars", "lines", "tok", "model", "allowed_tools", "path"]))
    print(table("Agents", ag, ["layer", "name", "desc_chars", "tok", "model", "tools", "path"]))
    print(table("MCP servers", mcp, ["source", "name", "type", "command"]))
    print(table("Other .claude dirs", other, ["layer", "dir", "files", "tok"]))
    print(table("Worktrees", wt, ["dir", "trees", "size"]))
    print(table("CI workflows that call Claude", ci, ["file", "triggers", "models"]))
    print(table("Same name in more than one place", dupes, ["name", "where"]))
    print(f"## Plugin skills ({len(plugin_skills)}), ≈{sum(p['desc_chars'] for p in plugin_skills)//4} tok of descriptions if all enabled\n")
    print(", ".join(sorted({p["name"] for p in plugin_skills})) or "(none)")


if __name__ == "__main__":
    main()
