#!/usr/bin/env python3
"""Minimal TypeSafe System One (Jev) client: batched, parallel, stdlib only.

Jev answers typed questions (choice / noul / score) about a `state` with calibrated
probabilities. It's ~0.15 s per request and ~$0.04 per million input tokens, so the audit uses it
for the narrow, high-volume judgments (which changelog entries matter, which files deserve a
read) and leaves reading and writing to Claude.

Key: $TYPESAFE_API_KEY, else parsed from ~/.zshrc.local or ~/.claude/.env (Claude Code's Bash
tool doesn't source interactive zsh files). No key → available() is False and callers fall back.
"""
import json
import os
import re
import urllib.request
from concurrent.futures import ThreadPoolExecutor
from pathlib import Path

URL = "https://api.typesafe.ai/v1/systemone"
MODEL = os.environ.get("JEV_MODEL", "jev-latest")
# 64k tokens per request; leave headroom for state + JSON overhead.
MAX_REQ_CHARS = 150_000


def _key():
    k = os.environ.get("TYPESAFE_API_KEY")
    if k:
        return k
    for f in (Path.home() / ".zshrc.local", Path.home() / ".claude" / ".env"):
        try:
            m = re.search(r"^\s*(?:export\s+)?TYPESAFE_API_KEY=[\"']?([^\"'\s]+)", f.read_text(), re.M)
        except OSError:
            continue
        if m:
            return m.group(1)
    return None


KEY = _key()
usage = {"requests": 0, "input_tokens": 0}


def available():
    return bool(KEY)


def ask(state, questions, timeout=30):
    """One request: `questions` is {id: question}. Returns {id: answer} or raises."""
    body = json.dumps({"state": state, "model": MODEL, "questions": questions}).encode()
    req = urllib.request.Request(URL, data=body, headers={
        "Authorization": f"Bearer {KEY}", "Content-Type": "application/json"})
    with urllib.request.urlopen(req, timeout=timeout) as r:
        d = json.loads(r.read())
    usage["requests"] += 1
    usage["input_tokens"] += (d.get("usage") or {}).get("input_tokens", 0)
    return d["answers"]


def ask_many(state, questions, workers=8):
    """Split a large question map into request-sized chunks and run them in parallel."""
    base = len(json.dumps(state)) + 200
    chunks, cur, size = [], {}, base
    for qid, q in questions.items():
        n = len(json.dumps(q))
        if cur and size + n > MAX_REQ_CHARS:
            chunks.append(cur)
            cur, size = {}, base
        cur[qid] = q
        size += n
    if cur:
        chunks.append(cur)
    out = {}
    with ThreadPoolExecutor(workers) as ex:
        for ans in ex.map(lambda c: ask(state, c), chunks):
            out.update(ans)
    return out


def ask_each(items, workers=16):
    """[(state, questions)] → [answers], one request per state, in parallel."""
    with ThreadPoolExecutor(workers) as ex:
        return list(ex.map(lambda sq: ask(*sq), items))


def cost_line():
    return (f"jev: {usage['requests']} requests, {usage['input_tokens']} input tokens "
            f"(≈${usage['input_tokens'] * 0.042 / 1e6:.4f})")
