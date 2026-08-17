# Scope Workflow

Turn hours into a budget, size the subject against it, and — when it doesn't fit — negotiate a cut that leaves a whole, useful capability inside six weeks. Produces the **track**: the section being taken now, plus the sections that follow.

## Voice Notification

```bash
curl -s -X POST http://localhost:31337/notify \
  -H "Content-Type: application/json" \
  -d '{"message": "Running Scope in Curriculum"}' \
  > /dev/null 2>&1 &
```

Running **Scope** in **Curriculum**...

## Step 1 — Compute the Real Budget

```
raw     = 6 weeks × hours per week
budget  = raw × 0.85          # slippage: illness, travel, work, life
```

State both numbers out loud. The 15% haircut is not pessimism — it is the difference between a plan that survives one bad week and one that gets abandoned in it. If the learner has a known interruption (a trip, a release, a holiday), subtract that week's hours specifically instead of relying on the average.

## Step 2 — Size the Subject

Read `References/ScopingHeuristics.md` for the anchor table. Estimate the hours from the learner's **current** position, not from zero — the assessment's transfer assets and Solid sub-domains cut the anchor, sometimes by half.

Write the estimate as a range and name what drives it:

> "Conversational-plus-can-build-a-model in options pricing anchors at 40-80h from a standing start. You placed Solid on probability and Shaky on volatility, so call it 30-50h for you. Your budget is 25h."

## Step 3 — The Three Outcomes

### A. Fits (estimate ≤ budget)

Say so plainly and go straight to Design. Do not manufacture a rescope to look rigorous.

### B. Too small (estimate ≤ 50% of budget)

Say so. Six weeks of padding is worse than an honest offer. Present two options and let them choose:
- **Raise the bar** — same subject, a harder demonstration (production-grade rather than working; unassisted rather than referenced).
- **Widen the domain** — pull the natural next section forward into the same six weeks.

Never pad. Filler weeks are how a course loses credibility, after which nothing in it gets done.

### C. Doesn't fit (estimate > budget) — the rescope conversation

Say the overage as a ratio, because it sets expectations honestly: *"That's roughly 6× the time you have."* Then present three cuts, in this preference order, each with its own capability bar. Recommend one, and say why.

| Cut | What it does | Use when |
|-----|--------------|----------|
| **1. Narrow the domain** | Take one slice of the subject and learn it whole. "Spanish" → "survival travel Spanish: present and past, 800 words, spoken." | Default. The subject has natural sub-domains that stand alone. |
| **2. Narrow the depth** | Keep full breadth, lower the bar. Recognition instead of production; can-read instead of can-write; can-evaluate instead of can-build. | The learner needs coverage now — a new job, a decision to make — more than they need mastery of a part. |
| **3. Narrow the application** | Aim everything at one concrete artifact. "Machine learning" → "ship one working recommender on my own data." | There's a real project waiting. Strongest motivation, and the artifact proves the learning. |

**Cuts that are forbidden:**
- Dropping the capstone to fit more topics. The capstone *is* the learning; the topics are scaffolding.
- Spreading thin across everything ("we'll touch each area lightly"). This produces a tour, not a capability, and it is the default failure mode of self-made study plans.
- Extending past six weeks to avoid choosing. If the learner wants twelve weeks, that's two sections with a re-assessment between them — which is better, and is what the track gives them.

Present the cuts as a choice, not a verdict. The learner knows which slice matters to them; you know which slices are coherent. If they reject all three and insist on the full scope, say once — in one or two sentences — what will realistically be true at week six under that plan, then build it as asked and note the assumption in `CURRICULUM.md`.

## Step 4 — Lay Out the Track

Whatever the outcome, write the **whole subject** as a numbered track, so the six weeks read as a deliberate first section rather than an arbitrary fragment:

```
Section 1 (weeks 1-6, now):   <capability bar>          ← designed in detail
Section 2 (next 6 weeks):     <capability bar>          ← one paragraph
Section 3:                    <capability bar>          ← one paragraph
...
Section N:                    <the original ask, achieved>
```

Rules:
- Every section ends in a demonstrable capability, not a topic list.
- Only Section 1 gets detailed. Later sections get one paragraph each — they'll be redesigned after re-assessment, and detail written now is detail written for a person who no longer exists.
- Give the track a realistic total: "the full original ask is roughly 5 sections, about 9 months at 5h/week." Learners can accept a long road; they can't accept an invisible one.

## Step 5 — Confirm the Bar, Then Route

Write the Section 1 capability bar in this exact form and get explicit agreement on it:

> **By <date>, I can <observable action>, <unaided / with docs only>, in <time or quality constraint>.**

Examples of a good bar:
- "I can hold a 15-minute unscripted conversation with a native speaker about travel plans, past and present tense, without switching to English."
- "I can port a 500-line Python parser to Rust, with tests passing and no `unsafe`, in under 8 hours."
- "I can build a three-statement model for a company from its 10-K in under 4 hours, unaided, and defend every assumption."

Examples of a bad bar (reject these): "understand Rust", "be conversational in Spanish", "know financial modeling". No observable action, no way to grade week six.

Record the track and the bar into `CURRICULUM.md` (from `Templates/Curriculum.md`), then route to `Workflows/Design.md`.

## Gotchas

- **The anchor table is anchors, not truth.** Adjust hard on the assessment. Someone with three prior languages learns a fourth much faster; someone with no programming background learns their "first" language far slower than the table says.
- **Deadlines override everything.** A real exam date or trip date replaces the six-week frame — say so and build to the real date instead of pretending it's six weeks.
- **Motivation is a scoping input.** A learner with a waiting project will sustain more hours than they estimated; a learner with vague curiosity will sustain fewer. Weight the haircut accordingly.
- **Don't rescope silently.** Shrinking the ask without saying so reads as the model misunderstanding the request. Name the cut, name the ratio, get agreement.
