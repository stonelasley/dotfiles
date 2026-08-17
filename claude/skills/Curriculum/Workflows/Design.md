# Design Workflow

Write the six weeks. Every week has one capability, a time-blocked budget that sums correctly, and a check that says whether it was reached.

## Voice Notification

```bash
curl -s -X POST http://localhost:31337/notify \
  -H "Content-Type: application/json" \
  -d '{"message": "Running Design in Curriculum"}' \
  > /dev/null 2>&1 &
```

Running **Design** in **Curriculum**...

## Step 1 — Inputs

Read before writing a single week: `ASSESSMENT.md` (the map, the miscalibrations, the failure history), the Section 1 bar and track from `CURRICULUM.md`, `References/LearningScience.md` (the methods below are not optional decoration), and `USER/CUSTOMIZATIONS/SKILLS/Curriculum/PREFERENCES.md` if it exists.

## Step 2 — Work Backwards From the Capstone

The capstone is the demonstration in the capability bar. Design it **first**, in detail, then ask of every candidate topic: *is this on the path to the capstone?* If no, it goes in "Deliberately excluded" — visible, so it reads as a decision rather than an omission.

A good capstone is:
- **Produced, not consumed** — built, written, spoken, performed, shipped.
- **Witnessed** — someone else sees it: a conversation partner, a code review, a published post, a recorded run. Witnessed work gets finished.
- **Real** — the learner's own data, their own project, their own trip. Toy capstones get abandoned first.

## Step 3 — Sequence the Weeks

Ordering rules, in priority order:

1. **Week 1 ships something on day one.** Trivially small, end to end: hello-world compiled and run, ten sentences spoken aloud to someone, one spreadsheet built. Front-loads the environment/tooling risk and buys momentum, which is the scarcest resource in week 3.
2. **Miscalibrations early.** What they're confidently wrong about is load-bearing and won't self-correct. Weeks 1-2.
3. **Foundational before dependent.** Obvious, but only after the two rules above.
4. **Weeks 5-6 integrate.** Capstone build and the demonstration. No new concepts in week 6 — week 6 is for consolidation and the demo.
5. **Skip what's Solid.** The assessment exists to buy you weeks. If they placed L4 on a sub-domain, do not spend a week on it; a single retrieval check confirms it and moves on.

## Step 4 — Time-Block Every Week Against the Budget

Each week states its hours **by activity, summing exactly to the weekly budget**. This is the constraint that turns a wish into a plan.

Default split for a 5h week (scale proportionally):

| Activity | Share | 5h week | Purpose |
|----------|-------|---------|---------|
| Intake (read/watch/listen) | ≤30% | 1.5h | acquiring the concepts |
| Production (build/write/speak/solve) | ≥50% | 2.5h | where the learning happens |
| Retrieval + spaced review | ~15% | 0.75h | making it stick |
| Reflection / logging | ~5% | 0.25h | steering |

If intake exceeds 30%, the week is a reading list, not a course. Rebalance.

Match the blocks to the session shape from the assessment: someone with two 20-minute weekday gaps and one Saturday block gets retrieval in the gaps and production in the block — not a plan that assumes three even evenings.

## Step 5 — Write Each Week

Each week gets exactly this structure:

```markdown
### Week N — <one-line capability, verb first>

**Bar:** By the end of this week I can <observable action>, <conditions>.

**Concepts (max 5):** ...

**Intake (Xh):** <specific resource, specific chapters/sections, what to skip and why>

**Production (Xh):** <the thing they make this week — concrete, gradeable>

**Retrieval (Xh):** <questions/drills from this week AND from weeks N-1 and N-3>

**Check:** <how they know they passed — a task, not a feeling>

**If you fall behind:** <compressible / not compressible, and what to drop first>
```

Five concepts is a ceiling, not a target. A week with nine concepts is two weeks pretending to be one.

## Step 6 — Resources: Verify or Mark

For each named resource, give the **why** and the **what to skip**. A book with "chapters 1-4 and 9, skip the rest — 6 covers macros which we're not doing" is a usable instruction; a bare title is a bookshelf.

Prefer **one primary spine** plus supplements. Multiple parallel primary resources is tutorial-hopping with better branding, and it is the most common way self-study dies.

**Verification is mandatory.** Invented titles, editions, chapter numbers, and URLs are exactly what a model produces under pressure to be helpful. Either:
- verify via web search/fetch that the resource exists and is current (`Skill("Research")` when the spine needs real work), or
- mark it `[unverified]` and tell the learner to confirm before buying.

Never present an unverified resource as verified. If the subject moves fast (a language runtime, a framework, a regulation), check the resource's date and say so.

## Step 7 — Carry the Countermeasure

The assessment recorded what killed prior attempts. Put an explicit rule in the plan against it. Examples:

| Failure history | Rule in the plan |
|-----------------|------------------|
| "I always tutorial-hop around week 3" | One spine. No new resources before week 4 without deleting one. |
| "I stop when I get stuck and don't come back" | 25-minute stuck rule: hint ladder, then ask, then move on and log it. Never a silent stall. |
| "I get busy and just stop" | Weeks 3 and 5 are marked compressible with a defined 90-minute minimum version. |
| "I never practice speaking, only study" | Production block is speaking-only; reading doesn't count toward it. |

## Step 8 — Write CURRICULUM.md and Open the Ledger

Fill `Templates/Curriculum.md` into the course directory. Initialize `PROGRESS.md` from `Templates/Progress.md`. Append one line to `CURRICULA/INDEX.md`.

Then show the learner the six week headlines and the capstone — not the whole file — and ask whether week 1 starts now or on a chosen date. Offer to run the first session.

## Gotchas

- **A plan the learner didn't agree to is a document, not a course.** Confirm the bar and the capstone before writing detail.
- **Don't schedule the later sections in detail.** They get redesigned after re-assessment.
- **Beware the beautiful week 1.** Effort tends to concentrate in the first week and thin out by week 5. Write week 5 and 6 with the same specificity — they're the weeks that decide whether anything was learned.
- **Six weeks of new concepts is a mistake.** Weeks 5-6 must be integration; a course that introduces new material in week 6 ends with a pile of unconsolidated fragments.
- **Rebuild, don't patch, after a failed week.** If Review marks two consecutive FAILs, re-run Design for the remaining weeks rather than bolting on repair blocks.
