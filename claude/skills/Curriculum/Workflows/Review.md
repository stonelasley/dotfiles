# Review Workflow

Test the week's bar honestly, then adapt the weeks that remain. Also runs the end-of-course retro.

## Voice Notification

```bash
curl -s -X POST http://localhost:31337/notify \
  -H "Content-Type: application/json" \
  -d '{"message": "Running Review in Curriculum"}' \
  > /dev/null 2>&1 &
```

Running **Review** in **Curriculum**...

## Mode A — End-of-Week Review

### Step 1 — Run the Check, Don't Discuss It

The week's plan states a check. **Administer it**, closed-book, as a task — do not ask "do you feel like you got it?" Self-assessment of learning is systematically wrong, and reliably wrong in the direction of overconfidence for material that was recently read.

### Step 2 — Grade Against the Bar

| Verdict | Meaning |
|---------|---------|
| **PASS** | Did the thing, unaided, at the stated quality. |
| **PARTIAL** | Did it with hints, or slower/rougher than the bar. |
| **FAIL** | Couldn't do it, or didn't get to the check. |

Grade the demonstration, not the effort. A learner who worked hard and can't do the thing is a FAIL on the week, and telling them otherwise costs them week 4.

### Step 3 — Adapt the Remaining Weeks

| Verdict | Action |
|---------|--------|
| **PASS**, comfortably and under time | Raise the next week's bar, or pull material forward from Section 2. Say why. |
| **PASS** | Continue as planned. |
| **PARTIAL** | Insert a repair block into the next week (typically 60-90 min), and compress that week's lowest-value intake to pay for it. Never add hours the learner doesn't have. |
| **FAIL** | Repeat the capability inside next week with a different method — if reading failed, build; if building failed, get a worked example first. Compress a later week to absorb the slip, and say which one. |
| **Two consecutive FAILs** | Stop patching. Re-run `Workflows/Design.md` for the remaining weeks, and consider whether the Scope cut was wrong — usually it was too ambitious, occasionally the format was wrong for this learner. |

Every adaptation is written into `CURRICULUM.md` (edit the affected weeks in place) and logged in `PROGRESS.md`. A curriculum that doesn't change after a FAIL isn't a plan, it's a wish.

### Step 4 — Log

```markdown
## <date> — Week N review
- Check: <what was administered>
- Verdict: PASS | PARTIAL | FAIL — <one line of evidence>
- Hours actually spent: <n> (planned: <n>)
- Adaptation: <what changed in the remaining weeks>
```

Track planned-vs-actual hours every week. After two weeks the real budget is known, and it is usually not the one estimated at Scope. Re-budget rather than letting the plan drift out of contact with reality.

## Mode B — End-of-Course Retro (after week 6)

### Step 1 — The Demonstration

Run the capstone demonstration against the Section 1 capability bar, witnessed where the bar says witnessed. Grade PASS / PARTIAL / FAIL against the bar as written at Scope — not against a bar quietly lowered along the way.

### Step 2 — The Decision

Present three honest options:

1. **Next section** — re-run Assess (the map is six weeks stale and should have moved a lot), then Scope and Design for Section 2.
2. **Consolidate** — no new section. A maintenance schedule: retrieval every two weeks, one production block a month, for as long as the capability needs to stay live. Choose this when the bar is met and the need is met.
3. **Stop** — the capability was the goal, or the subject turned out not to matter. A finished section and an honest stop is a success, not an abandonment. Record it as such.

### Step 3 — Write What Was Learned About the Learner

This is the compounding step. Append to `~/.claude/LIFEOS/USER/CUSTOMIZATIONS/SKILLS/Curriculum/PREFERENCES.md` (create it if absent) what this course proved about **how this person learns**, not about the subject:

```markdown
## <subject> — <dates> — <PASS/PARTIAL/FAIL>
- Estimated Xh/week, actually sustained Yh/week.
- Worked: <methods that produced PASS weeks>
- Didn't: <methods that produced FAIL weeks>
- Session shape that held: <when and how long>
- Motivation held / faded at: <week>, because <reason>
```

The next curriculum reads this file at Design and starts smarter. Keep it to observations with evidence from the ledger — this file is a record, not a personality profile.

### Step 4 — Update the Index

Set the course's status in `CURRICULA/INDEX.md` to `completed` / `stopped` / `abandoned`, with the verdict.

## Gotchas

- **Grade inflation destroys the instrument.** If week 3 is a PARTIAL and gets recorded as a PASS, week 6 arrives with a capability that isn't there, and the learner concludes the whole method doesn't work.
- **"I ran out of time" is a FAIL on the week and a signal about the budget**, not a moral failing. Re-budget; don't just apologize and continue.
- **The retro is the most valuable 20 minutes of the course.** Don't let it be skipped in the glow of finishing.
- **A failed course is worth writing down too.** The abandoned-at-week-3 record is what makes the next Scope realistic.
