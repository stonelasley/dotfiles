# Assess Workflow

Find the edge of the learner's understanding through an adaptive, laddered interview, then write `ASSESSMENT.md`. This is the entry point for every new course.

## Voice Notification

```bash
curl -s -X POST http://localhost:31337/notify \
  -H "Content-Type: application/json" \
  -d '{"message": "Running Assess in Curriculum"}' \
  > /dev/null 2>&1 &
```

Running **Assess** in **Curriculum**...

## Step 0 — Sufficiency Check

1. Read the user-prompt arguments and recent conversation.
2. Do I know **what subject** and roughly **why now**? Those two are required; everything else the interview will surface.
3. If the subject is named but nothing else → proceed, the interview covers it.
4. If no subject is identifiable → ask one question: "What do you want to learn?" and halt.
5. Check `~/.claude/LIFEOS/MEMORY/LEARNING/CURRICULA/` for an existing course on this subject. If one exists, say so and route to Session or Review instead of re-interviewing.

## Step 1 — Load Context Before Asking Anything

Read, if present, and do not ask for what these already answer:

| Source | What it gives you |
|--------|-------------------|
| `~/.claude/LIFEOS/USER/CUSTOMIZATIONS/SKILLS/Curriculum/PREFERENCES.md` | how this learner learns; what has failed before |
| `~/.claude/LIFEOS/MEMORY/LEARNING/CURRICULA/INDEX.md` | prior courses, completed and abandoned |
| `~/.claude/LIFEOS/USER/TELOS/GOALS.md`, `CHALLENGES.md` | whether this subject serves a stated goal |
| `~/.claude/LIFEOS/USER/PROJECTS.md`, `TECHSTACKPREFERENCES.md` | adjacent knowledge to probe for transfer, and a realistic capstone |
| `~/.claude/LIFEOS/USER/TELOS/BOOKS.md` | what they've already read in or near the domain |

Adjacent knowledge is the highest-value thing you can find here. Someone who writes C++ starts Rust at a different place than someone who writes Python; someone who speaks French starts Spanish at a different place than someone who speaks only English. Probe transfer explicitly in Step 3.

## Step 2 — Frame the Interview (say this, briefly)

Set expectations in three sentences, then start. Cover:

- This will be 10-15 questions that get harder until they stop being answerable — **that's the point**, hitting the ceiling is the measurement, not a failure.
- Guessing is fine; say so when guessing, because "I'm not sure" is as useful a data point as a right answer.
- "Skip" moves on, "stop" ends the interview and plans from what's been gathered.

Do not announce a score, a level, or a grade at any point during the interview.

## Step 3 — The Ladder

**One question per message. Never batch. Never number them into a list.**

### Difficulty levels

| Level | Question shape | Example (any subject) |
|-------|----------------|----------------------|
| L0 | Recognition / vocabulary | "What does <term> mean in this context?" |
| L1 | Comprehension | "Explain <concept> in your own words, as if to a colleague." |
| L2 | Application | "Given <concrete scenario>, what would you do?" |
| L3 | Analysis / diagnosis | "Here's something that's broken/wrong. What's wrong with it?" |
| L4 | Synthesis / design | "Design a <thing> under <constraint>. Walk me through your choices." |
| L5 | Expert judgment | "When does the standard advice about <X> stop being right?" |

### Movement rule

Read each answer for **correctness** and **confidence** (their hedging language, or ask "how sure are you, 1-5?" when it isn't obvious):

| Answer | Next question |
|--------|---------------|
| Correct and fluent | +2 levels |
| Correct but hesitant, or reasoned to it slowly | +1 level |
| Partially correct | stay at level, different sub-domain |
| Wrong, and they knew it | −1 level, different sub-domain |
| **Wrong, and confident** | flag as a **miscalibration**, then −1 level and return here later |

### Breadth rule

Sample **3-5 sub-domains**, not one. A single number is not a map. Decompose the subject first (silently) into its natural sub-domains, then walk the ladder within each. For example: a programming language splits into syntax/semantics, memory and data model, tooling and ecosystem, idiom and design, concurrency/runtime. A spoken language splits into vocabulary, grammar production, listening, speaking fluency, reading. A finance subject splits into instruments, math/valuation, market structure, risk, regulation.

### Stopping rule

Stop at the first of:
- Two misses at level N plus two hits at N−1 in the same sub-domain (the frontier is located), across the sub-domains you're sampling.
- 15 questions.
- The learner says stop, or answers are getting shorter and flatter — fatigue corrupts the measurement.

### Tone rules

- Never say "correct", "wrong", "good job", or "not quite" mid-interview. Acknowledge in one clause and move: "Got it — next one."
- Never teach during the assessment. The urge to correct a wrong answer is strong; resist it. Corrections here get forgotten; the same content in week 2 lands.
- If they ask "was that right?", say you'll cover it all in the assessment summary, and move on.

## Step 4 — The Non-Knowledge Half

Knowledge is only half the input. Ask these too, conversationally, woven in or at the end (batching is fine here — these aren't laddered):

1. **Why now?** Is there a deadline, a job, a trip, a project waiting on this?
2. **What does "mastered" look like to you?** Push for an observable demonstration — "I can X, unaided" — not a feeling. This becomes the capability bar.
3. **Hours per week, realistically, and when?** Weekday evenings, weekend blocks, 20-minute gaps? Session shape changes the design.
4. **Have you tried before?** What killed it? This is the most predictive single answer in the interview.
5. **What format actually works for you** — reading, video, building, talking to someone, problem sets?
6. **What do you have?** Budget, tools, hardware, a tutor, a community, colleagues who know this, a real project to aim at.

## Step 5 — Write ASSESSMENT.md

Create the course directory and write the assessment from `Templates/Assessment.md`:

```bash
mkdir -p ~/.claude/LIFEOS/MEMORY/LEARNING/CURRICULA/$(date +%Y-%m-%d)-<subject-slug>/Notes
```

The file must contain:

- **Skill map** — a table of sub-domain × verdict (`Solid` / `Shaky` / `Absent`), each with the specific evidence from the interview ("placed L3 on diagnosis, missed L4 design").
- **Miscalibrations** — confidently wrong answers, verbatim where possible. These get priority in the plan; the learner will never seek them out unprompted.
- **Transfer assets** — adjacent knowledge that shortens the course, named.
- **Constraints** — hours/week, session shape, deadline, budget, tools.
- **Stated mastery bar** — their words, as a demonstration.
- **Failure history** — what killed prior attempts, and the countermeasure the plan will carry.

## Step 6 — Play It Back, Then Route

Summarize the map in under 200 words, in plain language, and ask one question: **"Does that match how it feels from the inside?"** Learners correct this usefully — the interview samples, they know the whole.

Then route straight into `Workflows/Scope.md`. Do not stop and wait for permission; the assessment on its own is not the deliverable.

## Gotchas

- **A model can generate ten questions instantly. Don't.** The adaptivity is the measurement; a static list measures nothing.
- **Confidence questions decay if overused.** Ask "how sure?" when hedging is ambiguous, not after every answer.
- **Subjects with no factual surface still ladder** — for a physical or creative skill, ladder on judgment and diagnosis ("here's a recording/photo/draft, what's wrong with it?") rather than recall.
- **Don't let the interview become the lesson.** If it runs past ~20 minutes, you're teaching, not measuring.
