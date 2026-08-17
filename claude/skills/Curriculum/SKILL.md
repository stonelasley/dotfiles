---
name: Curriculum
version: 1.0.0
description: "Builds a personalized six-week course for any subject — starts with an adaptive interview that ladders difficulty to find the edge of your knowledge, rescopes the subject when it is too big to master in the time available, then designs a week-by-week plan with a capability bar, a capstone, and spaced-retrieval checks. Runs the weekly sessions and the end-of-week reviews too. USE WHEN teach me X, help me learn X, learn a language, learn a programming language, get up to speed on X, study plan, learning plan, curriculum, course, syllabus, self-study, skill up, master X, six week plan, what should I learn first, test my knowledge of X, assess my level, where are my gaps, weekly study session, tutor me, review my week. NOT FOR a one-off explanation of a concept (just answer it), gathering source material on a topic (use Research), academic paper discovery (use ArXiv), or refreshing constitutional context (use Interview)."
---

# Curriculum — assess, scope, and run a six-week course on any subject

## What It Does

Curriculum turns "I want to learn X" into a course you can actually finish. It interviews you first — progressively harder questions until it finds where your understanding stops — then checks whether X fits the hours you have. If it doesn't, it walks you through a rescope so that six weeks buys a whole, useful capability instead of a shallow tour, and sketches the follow-on sections that cover the rest. Then it writes the plan, runs the weekly sessions, and grades each week against the bar.

Subject-agnostic by design: a programming language, a spoken language, options pricing, cooking, systems design, guitar.

## The Problem

Self-directed learning fails in two predictable places. First, the plan is written for a beginner you aren't — it wastes weeks on what you already know and skips the thing you're quietly wrong about, because nobody measured. Second, the scope is a fantasy: "learn Spanish" or "learn machine learning" is not a six-week objective, so week four arrives with nothing finished and the plan gets abandoned. Curriculum attacks both: it measures before it plans, and it refuses to write a plan whose hours don't add up.

## How It Works

Five workflows, run in order the first time, then Session and Review on repeat:

**Assess** ladders questions across sub-domains to map what's solid, shaky, and absent — and where you're confidently wrong. **Scope** converts your hours into a real budget, sizes the subject against it, and negotiates the cut if it doesn't fit. **Design** writes the six weeks: one testable capability per week, time-blocked to the budget, ≥50% production, ending in a capstone. **Session** runs a study block as a tutor — retrieval first, hints before answers. **Review** tests the week's bar honestly and adapts the remaining weeks.

## Customization

**Before executing, check for user customizations at:**
`~/.claude/LIFEOS/USER/CUSTOMIZATIONS/SKILLS/Curriculum/`

If this directory exists, load and apply any PREFERENCES.md, configurations, or resources found there. These override default behavior. If the directory does not exist, proceed with skill defaults.

`PREFERENCES.md` accumulates what has been learned about how *this* learner learns — the retro at the end of every course writes to it. Read it before designing anything.

## Voice Notification

**When executing a workflow, do BOTH:**

1. **Send voice notification**:
   ```bash
   curl -s -X POST http://localhost:31337/notify \
     -H "Content-Type: application/json" \
     -d '{"message": "Running WORKFLOWNAME in Curriculum"}' \
     > /dev/null 2>&1 &
   ```

2. **Output text notification**:
   ```
   Running **WorkflowName** in **Curriculum**...
   ```

## Workflow Routing

| Workflow | Trigger | File |
|----------|---------|------|
| **Assess** | default entry; "teach me X", "help me learn X", "test my knowledge of X", "where are my gaps", "assess my level" | `Workflows/Assess.md` |
| **Scope** | runs automatically after Assess; standalone on "is this too broad", "rescope", "narrow this down", "what can I actually finish" | `Workflows/Scope.md` |
| **Design** | runs automatically after Scope; standalone on "write the plan", "redesign week 4", "rebuild the curriculum" | `Workflows/Design.md` |
| **Session** | "study session", "tutor me", "let's do week 3 day 1", "I'm stuck on…", "quiz me" | `Workflows/Session.md` |
| **Review** | "end of week review", "grade my week", "did I pass week 2", "course retro", "I'm falling behind" | `Workflows/Review.md` |

**Routing rule:** if a course directory already exists for the subject (see Artifacts below), route to **Session** or **Review**, not Assess — do not re-interview someone mid-course. Re-run Assess only at a section boundary, or when the learner explicitly asks to be re-tested.

## Artifacts

One directory per course, under LifeOS durable learning memory:

```
~/.claude/LIFEOS/MEMORY/LEARNING/CURRICULA/<YYYY-MM-DD>-<subject-slug>/
├── ASSESSMENT.md   # skill map, miscalibrations, constraints  (Assess)
├── CURRICULUM.md   # the track, the six weeks, the capstone   (Scope + Design)
├── PROGRESS.md     # append-only ledger, one entry per session/review
└── Notes/          # freeform working notes, drills, artifacts
```

Templates for the first three live in `Templates/`. `CURRICULA/INDEX.md` holds one line per course — append on create, update the status on completion.

## Examples

**Example 1: subject fits the budget**
```
User: "Help me learn Rust — I've got about 5 hours a week."
→ Assess: 11 questions, from "what does the borrow checker do" up to designing a
  lock-free queue. Solid on systems concepts (C++ background), absent on lifetimes
  and async, confidently wrong about Arc<Mutex<T>> cost.
→ Scope: 30h budget, minus slippage = 25h. Working Rust productivity for an existing
  systems programmer anchors at 40-60h — over budget. Rescoped by application:
  "port my log parser to Rust and ship it."
→ Design: six weeks, capstone is the ported parser, weeks 2 and 3 hammer lifetimes
  because that's the measured gap, async deliberately excluded and listed as Section 2.
```

**Example 2: subject far too broad**
```
User: "I want to learn Spanish."
→ Assess: no prior Spanish, some French. 4 hours/week.
→ Scope: 24h budget. A2 for an English speaker with Romance-language transfer anchors
  at 150-250h — 6-10x over. Offers three cuts; user picks the narrow-domain cut:
  "survival travel Spanish — present and past tense, 800 words, spoken."
→ Design: six weeks ending in a 15-minute unscripted conversation with a tutor.
  Sections 2-5 sketched (A2 completion, past/future depth, listening, reading).
```

**Example 3: mid-course**
```
User: "Grade my week 3."
→ Review: runs the week-3 capability check, marks PARTIAL, inserts a 90-minute repair
  block into week 4, compresses week 5's optional reading, logs to PROGRESS.md.
```

## Quick Reference

- **Measure before you plan.** Never write a curriculum without an assessment — a plan for a generic beginner is the failure mode this skill exists to kill.
- **The hours are the constraint.** Every week is time-blocked and must sum to the stated budget. A plan that doesn't add up is a lie.
- **≥50% production, ≤30% intake.** Reading and watching is the smallest slice, not the biggest.
- **One capability bar per week**, stated as an observable demonstration, not a topic list.
- **Cut scope, never the capstone.** Finishing something small beats abandoning something large.
- **Confidently wrong beats simply unknown.** Miscalibrations get priority in the plan — the learner won't seek them out on their own.

## Gotchas

- **Never batch the interview questions.** One at a time, adapting to each answer, is the whole point; a numbered list of ten questions is an ordinary quiz and measures nothing about the frontier.
- **Don't grade the interview out loud.** "Correct!" / "Not quite" turns an assessment into a test and the learner starts performing rather than revealing. Acknowledge and move.
- **Never invent resources.** Book titles, course URLs, and chapter numbers are exactly what a model confabulates. Verify with a web fetch, or mark the item `[unverified]` and say so.
- **Beware the mid-course re-interview.** Assess is expensive and demoralizing to repeat. Route existing courses to Session/Review.
- **A subject can be too small.** Six weeks of a padded plan is worse than a two-week plan plus a harder bar. Say so when it happens.
- **Time budgets slip.** Subtract 15% before planning, and mark which weeks are compressible so falling behind has a defined recovery path rather than an abandonment.

## Related

- `Skill("Research")` — gather source material on a topic; Curriculum calls it when the resource spine needs building.
- `Skill("Interview")` — refreshes constitutional TELOS context; different artifact, different purpose.
- `USER/TELOS/GOALS.md`, `USER/TELOS/CHALLENGES.md`, `USER/PROJECTS.md` — read these before Scope so the course serves a stated goal rather than a passing interest.
