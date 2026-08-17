# LearningScience

The methods a Curriculum course is built from, and why each one is in the plan. Design and Session both depend on these; they are the reason the plan looks the way it does.

## The Core Six

### 1. Retrieval practice
Pulling something out of memory strengthens it far more than putting it in again. Re-reading feels productive and mostly isn't; recalling feels harder and works. **In the plan:** every session opens closed-book, and every week's retrieval block draws from earlier weeks, not just the current one.

### 2. Spaced repetition
Material reviewed at expanding intervals survives; material reviewed once, massed, decays within days. **In the plan:** an item introduced in week N is reviewed in week N+1 and again in week N+3. Per-item, the intervals to aim for are day 1, day 3, day 7, day 14, day 30.

### 3. Interleaving
Mixing problem types within a block beats blocking one type at a time. It produces worse practice-session performance and better retention and transfer — which means the learner will feel it's going badly. Say so once, up front, so the discomfort reads as the method rather than as failure.

### 4. Deliberate practice
Practice at the edge of ability, on a specific weakness, with immediate feedback and correction. Time spent comfortably re-doing what's already solid is not practice; it's rehearsal. **In the plan:** the assessment's Shaky and Absent rows drive the drill sets, and the Solid rows get a single confirming check and nothing more.

### 5. The generation effect
Attempting an answer before being told it — even a wrong attempt — makes the correct answer stick harder than passive reception. **In the plan:** predict-before-explain in Session, and production blocks that precede the polished reference material rather than following it.

### 6. Elaboration and self-explanation
Explaining a concept in your own words, connecting it to what you already know, exposes exactly where understanding stops. Fluent jargon is the tell for the parts not yet understood. **In the plan:** every session closes with explain-it-back, and the vague spots become next session's retrieval items.

## Writing Objectives That Can Be Graded

Use action verbs that name an observable performance. The hierarchy, low to high:

| Level | Verbs | Bar shape |
|-------|-------|-----------|
| Remember | define, list, name | rarely a week's bar on its own |
| Understand | explain, summarize, paraphrase | week 1 material at most |
| Apply | use, solve, implement, perform | the typical week bar |
| Analyze | diagnose, compare, debug, critique | mid-course |
| Evaluate | judge, defend, choose between | late course |
| Create | design, build, compose, ship | the capstone |

Banned in a bar: *understand, know, be familiar with, get comfortable with, learn about*. None of them can be graded, and a bar that can't be graded silently becomes a PASS.

## Calibration

The assessment measures two things at once: what the learner can do, and whether they know what they can do.

- **Confident and wrong** — the dangerous quadrant. It won't self-correct, because there's no felt gap to drive a question. Highest priority in the plan, scheduled early.
- **Unconfident and right** — costs time and hesitation, not correctness. Fixed cheaply with a few successful reps; do not spend a week here.
- **Confident and right** — skip it. This is where the assessment buys back weeks.
- **Unconfident and wrong** — ordinary learning material. The bulk of the course.

## Time Allocation

| Activity | Share of the week | Why |
|----------|------------------|-----|
| Intake | ≤30% | necessary, and the easiest thing to over-consume |
| Production | ≥50% | where the capability is actually built |
| Retrieval / spaced review | ~15% | where it becomes durable |
| Reflection / logging | ~5% | where the plan stays honest |

A plan whose intake exceeds 30% is a reading list. Rebalance before showing it to the learner.

## Motivation and Attrition

Self-directed courses die at predictable points; the plan should be built to survive them.

- **Week 1** — environment and setup friction. Countermeasure: ship something trivial on day one, before anything is properly understood.
- **Week 3** — novelty is gone, competence isn't there yet. Countermeasure: schedule the most intrinsically interesting material here, and make week 3's deliverable visible to someone else.
- **Week 5** — the capstone looks too big. Countermeasure: the capstone was decomposed at Design and week 5 assembles pieces already built in weeks 2-4; it is never a from-scratch build.

Two structural aids across all three: **witnessed work** (a person expecting to see it) and **streak-independent recovery** (a defined minimum version of each week, so one missed week doesn't end the course).

## Domain-Specific Notes

| Domain | What differs |
|--------|--------------|
| **Spoken language** | Production (speaking) is the bottleneck and the thing learners avoid. Comprehensible input plus forced output; a conversation partner is worth more than any app. Vocabulary genuinely suits flashcards; grammar mostly doesn't. |
| **Programming language** | Fluency comes from reading idiomatic code and writing a real program, not from syntax tours. Front-load the model that differs from what they know (ownership, the type system, the concurrency model) — that's where the transfer breaks. |
| **Math / quantitative** | Problem sets are non-negotiable and worked examples precede independent problems. Skipping to the "intuition" without the mechanics produces recognition, not capability. |
| **Business / finance** | Build the artifact — the model, the memo, the deck. Case-based, with a real company's filings. Vocabulary is fast; judgment is slow and needs many cases. |
| **Physical / performance** | Short daily beats long weekly. Form feedback (video, mirror, coach) is required — practicing a flaw is worse than not practicing. |
| **Design / creative** | Deliberate imitation of specific work, then critique against it. A volume target beats a quality target early. |
