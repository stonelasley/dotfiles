# Session Workflow

Run one study block as a tutor. Retrieval first, production in the middle, explain-it-back at the end, logged on the way out.

## Voice Notification

```bash
curl -s -X POST http://localhost:31337/notify \
  -H "Content-Type: application/json" \
  -d '{"message": "Running Session in Curriculum"}' \
  > /dev/null 2>&1 &
```

Running **Session** in **Curriculum**...

## Step 1 — Locate the Course and the Block

Read `CURRICULUM.md` and `PROGRESS.md` from the course directory. Determine which week and which block is next from the ledger — not from the calendar. A learner two weeks behind schedule is on week 2, not week 4; never skip content to "catch up to the date."

Ask how long they've got **before** planning the block, and fit the session to the answer. A 25-minute session is a retrieval block plus one drill; do not start a 2-hour build in it.

## Step 2 — Open With Retrieval (first 10-15%)

Always. Every session opens with recall from memory, closed-book:

- 3-5 questions drawn from **last session**, **one week back**, and **three weeks back** (spacing schedule in `References/LearningScience.md`).
- Free recall beats recognition: "what were the three rules for X?" beats a multiple choice.
- Mark each as recalled / partial / gone. Anything gone re-enters next session's retrieval set.

This is not a warm-up. Retrieval practice is the single highest-yield activity in the course, and it is the one learners skip.

## Step 3 — The Block

Run whatever the week's plan says for this block, under these tutoring rules:

**The hint ladder.** When they're stuck, never open with the answer:
1. Point at the area: "the problem is in how the two are being combined."
2. Give the principle: "remember that X is always evaluated before Y."
3. Give the answer, then immediately ask them to re-derive or restate it.

Reaching for level 3 first is the difference between a tutor and an autocomplete. The struggle before the answer is what makes it stick.

**The 25-minute stuck rule.** If they're stuck longer than 25 minutes on one thing, resolve it, log it as a gap, and move on. A stall that runs past a session is how courses get abandoned.

**Generate before consuming.** Before explaining a new concept, ask them to predict: "how do you think this works?" A wrong prediction makes the correct explanation stick harder than a right one absorbed passively.

**Interleave.** Within a production block, mix problem types rather than blocking one type. It feels worse and works better; say so once so the discomfort isn't read as failure.

## Step 4 — Close With Explain-It-Back (last 5-10%)

Ask them to explain the session's core idea in plain language, out loud or in writing, as if to someone who doesn't know the subject. Where the explanation goes vague or reaches for jargon, that's the part not yet understood — note it, and it becomes retrieval material next session.

## Step 5 — Log

Append to `PROGRESS.md`:

```markdown
## <date> — Week N, <block name> (<minutes>m)
- Retrieval: <n> recalled, <n> partial, <n> gone → <items carried forward>
- Did: <what was actually produced>
- Stuck on: <items, with hint level reached>
- Explain-back gaps: <where the explanation went vague>
- Next: <the next block>
```

Working artifacts go in `Notes/`. Keep the ledger append-only — the record of a bad week is what makes the retro useful later.

## Gotchas

- **Skipping retrieval to "get to the real work" is the most common self-sabotage.** Hold the line; it's 10 minutes.
- **Praise the process, not the person.** "That reasoning was clean" beats "you're a natural" — the second makes struggle feel like disproof of talent, and struggle is the plan.
- **Don't lecture.** If the tutor is producing more words than the learner in a production block, the block has failed. Ask, don't tell.
- **Sessions that run long borrow from next week.** Ending on time with something finished beats running over with something abandoned.
- **Fitting the plan to the calendar corrupts the course.** Fit it to the ledger.
