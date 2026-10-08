#!/usr/bin/env python3
"""Measure how this repo's Claude setup is actually used, from local session transcripts.

Reads ~/.claude/projects/<repo-slug>/*.jsonl (the most recent N sessions) and reports:
  - slash commands typed, Skill tool calls, Agent calls (type + model), MCP calls per server
  - hook errors (which hook, what stderr said, how many sessions)
  - context injected by hooks per event (measured chars, not estimated)
  - main-session model mix
Evidence for "is this used?" and "what does this hook cost?" without grepping by hand.

usage: usage.py [repo_root] [--sessions N]   (default 50)
"""
import json
import re
import subprocess
import sys
from collections import Counter, defaultdict
from pathlib import Path


def repo_root(arg):
    if arg:
        return Path(arg).resolve()
    try:
        return Path(subprocess.run(["git", "rev-parse", "--show-toplevel"], capture_output=True,
                                   text=True, check=True).stdout.strip())
    except Exception:
        return Path.cwd()


def main():
    args = sys.argv[1:]
    n = 50
    if "--sessions" in args:
        i = args.index("--sessions")
        n = int(args[i + 1])
        del args[i:i + 2]
    root = repo_root(args[0] if args else None)
    slug = re.sub(r"[^A-Za-z0-9]", "-", str(root))
    pdir = Path.home() / ".claude" / "projects" / slug
    files = sorted(pdir.glob("*.jsonl"), key=lambda p: p.stat().st_mtime, reverse=True)[:n]
    if not files:
        print(f"no transcripts at {pdir}")
        return

    cmds, skills, agents, mcp, models = Counter(), Counter(), Counter(), Counter(), Counter()
    hook_err = defaultdict(lambda: [0, set(), ""])          # key -> [count, sessions, sample]
    inject = defaultdict(lambda: [0, 0, set()])              # hookName -> [total chars, count, sessions]
    first, last = None, None

    for f in files:
        sid = f.stem
        for line in f.open(errors="replace"):
            try:
                d = json.loads(line)
            except ValueError:
                continue
            ts = d.get("timestamp")
            if ts:
                first = min(first or ts, ts)
                last = max(last or ts, ts)
            t = d.get("type")
            if t == "attachment":
                a = d.get("attachment") or {}
                at = a.get("type", "")
                name = a.get("hookName") or a.get("hookEvent") or "?"
                if "error" in at:
                    msg = (a.get("stderr") or a.get("content") or "").strip().splitlines()
                    key = f"{name} :: {msg[-1][:120] if msg else at}"
                    e = hook_err[key]
                    e[0] += 1
                    e[1].add(sid)
                elif at in ("hook_additional_context", "hook_success"):
                    c = a.get("content")
                    size = sum(len(x) for x in c) if isinstance(c, list) else len(c or "")
                    if size:
                        ev = inject[name]
                        ev[0] += size
                        ev[1] += 1
                        ev[2].add(sid)
                continue
            m = d.get("message")
            if not isinstance(m, dict):
                continue
            if t == "assistant" and not d.get("isSidechain") and m.get("model"):
                models[m["model"]] += 1
            content = m.get("content")
            if isinstance(content, str):
                for c in re.findall(r"<command-name>/?([^<\s]+)</command-name>", content):
                    cmds[c] += 1
                continue
            for b in content or []:
                if not isinstance(b, dict):
                    continue
                if b.get("type") == "text" and t == "user":
                    for c in re.findall(r"<command-name>/?([^<\s]+)</command-name>", b.get("text", "")):
                        cmds[c] += 1
                if b.get("type") != "tool_use":
                    continue
                nm, inp = b.get("name", ""), b.get("input") or {}
                if nm == "Skill":
                    skills[inp.get("skill", "?")] += 1
                elif nm in ("Agent", "Task"):
                    agents[f'{inp.get("subagent_type") or "general"} @ {inp.get("model") or "inherit"}'] += 1
                elif nm.startswith("mcp__"):
                    mcp[nm.split("__")[1]] += 1

    if "--json" in sys.argv:
        print(json.dumps({"root": str(root), "sessions": len(files), "first": first, "last": last,
                          "commands": cmds, "skills": skills, "agents": agents, "mcp": mcp, "models": models,
                          "hook_errors": [{"key": k, "count": c, "sessions": len(s)} for k, (c, s, _) in hook_err.items()],
                          "inject": [{"hook": k, "avg_chars": t // c, "fires": c, "sessions": len(s)}
                                     for k, (t, c, s) in inject.items()]}))
        return

    print(f"# Usage: {root}\n")
    print(f"{len(files)} most recent sessions · {first or '?'} → {last or '?'} · source {pdir}\n")

    def top(title, c, k=25):
        print(f"## {title}")
        print(", ".join(f"{name} {cnt}" for name, cnt in c.most_common(k)) or "(none)")
        print()

    top("Slash commands typed", cmds)
    top("Skill tool calls", skills)
    top("Agent calls (type @ model)", agents)
    top("MCP calls by server", mcp)
    top("Main-session model (assistant turns)", models)

    print("## Hook errors")
    if not hook_err:
        print("(none)\n")
    else:
        print("| hook :: last stderr line | count | sessions |\n|---|---|---|")
        for k, (cnt, s, _) in sorted(hook_err.items(), key=lambda x: -len(x[1][1])):
            print(f"| {k.replace('|', '/')} | {cnt} | {len(s)}/{len(files)} |")
        print()

    print("## Context injected by hooks (measured)")
    print("| hook | avg chars | ≈ avg tok | fires | sessions |\n|---|---|---|---|---|")
    for k, (tot, cnt, s) in sorted(inject.items(), key=lambda x: -x[1][0]):
        print(f"| {k} | {tot // cnt} | {tot // cnt // 4} | {cnt} | {len(s)}/{len(files)} |")
    print("\nNames never seen above were not used in this window. Check the inventory against these lists"
          " before calling anything dead, and widen --sessions if the window is short.")


if __name__ == "__main__":
    main()
