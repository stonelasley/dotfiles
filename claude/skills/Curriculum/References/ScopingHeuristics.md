# ScopingHeuristics

Anchors for "how many hours is this, really." Used by `Workflows/Scope.md` to decide whether a subject fits the budget.

**These are anchors, not measurements.** They assume a motivated adult learner with deliberate practice, not passive study. Adjust hard on the assessment: adjacent knowledge routinely cuts an anchor by a third to a half, and a genuinely cold start routinely doubles it.

## Budget Math

```
raw    = 6 × hours per week
budget = raw × 0.85
```

Typical budgets: 3h/wk → 15h · 5h/wk → 25h · 8h/wk → 41h · 12h/wk → 61h · 20h/wk → 102h.

Most people have less than they think. If in doubt, use the lower figure — a course finished under budget can always have its bar raised at Review.

## Anchor Table

| Subject | Bar | Hours |
|---------|-----|-------|
| **Programming language**, already fluent in another | Productive on real work, idioms still rough | 40-60 |
| **Programming language**, already fluent in another | Idiomatic + ecosystem fluency | 150-300 |
| **Programming language**, first one ever | Can build and debug a small program unaided | 100-200 |
| **Framework or library**, language already known | Ship a working app | 20-40 |
| **Spoken language**, close to one you know | CEFR A2 (survival, past + present) | 150-250 |
| **Spoken language**, close to one you know | CEFR B1 (independent user) | 350-500 |
| **Spoken language**, distant (Mandarin, Arabic, Japanese, Korean for an English speaker) | CEFR A2 equivalent | 400-600 |
| **Spoken language**, any | Travel-survival: ~800 words, present + past, spoken | 40-80 |
| **Business/finance domain** (e.g. valuation, unit economics) | Conversant + can build the standard artifact | 40-80 |
| **Financial modeling** | Three-statement model from filings, unaided | 60-100 |
| **Math topic** (linear algebra, probability, statistics) | Working competence, can solve standard problems | 80-150 |
| **Data / ML** | Ship one working model end to end on own data | 60-120 |
| **Data / ML** | Understand the methods well enough to choose between them | 200-400 |
| **Instrument** | Play simple pieces recognizably | 60-100 |
| **Instrument** | Play comfortably in a group | 300-600 |
| **Physical skill** (a lift, a stroke, a stance) | Competent form under light load | 20-50 |
| **Craft** (cooking, woodworking, photography) | Reliably produce a good result in one style | 40-80 |
| **Vendor certification** | Pass the exam | use the vendor's published prep hours; they are usually honest |
| **Reading a technical book properly** (notes + exercises) | Retained, not just read | 3-6h per 100 pages |

## Adjustment Multipliers

Apply to the anchor, multiplicatively, from the assessment:

| Finding | Multiplier |
|---------|-----------|
| Strong adjacent domain (C++ → Rust; French → Spanish; stats → ML) | ×0.5-0.7 |
| Some prior exposure, gone stale | ×0.7-0.9 |
| Cold start, and no experience learning this *type* of subject | ×1.3-2.0 |
| Miscalibrations concentrated in foundations | ×1.2 (unlearning costs more than learning) |
| Has a coach, tutor, or expert colleague on tap | ×0.7 |
| Has a real project that requires the skill | ×0.8 (motivation and applied reps) |
| Learning purely for interest, no application | ×1.3 |

## Reading the Result

| estimate ÷ budget | Verdict |
|-------------------|---------|
| ≤ 0.5 | Too small — raise the bar or widen the domain. Do not pad. |
| 0.5 - 1.0 | Fits. Design it. |
| 1.0 - 1.5 | Fits with a trim — cut the two lowest-value sub-domains and say which. |
| 1.5 - 3 | Rescope. Narrowing the depth usually suffices. |
| > 3 | Rescope hard. Narrow the domain or the application, and lay out the full track so the size is visible. |

## Slicing a Subject Into Sections

Good slices stand alone — each ends in something demonstrable, and stopping after any one of them leaves the learner with a real capability rather than a third of a thing.

| Subject | A good track |
|---------|-------------|
| A spoken language | travel survival → A2 → past/future depth + listening → B1 conversation → reading/media |
| A programming language | port one real program → idiomatic patterns + testing → concurrency/async → ecosystem and tooling → performance |
| Machine learning | ship one supervised model on own data → evaluation and error analysis → the model-family landscape → deployment → deep learning |
| Personal finance | tax-advantaged accounts and allocation → own full plan, written → tax strategy → estate and insurance |
| Guitar | five chords + two songs → strumming and rhythm → barre chords and keys → fingerpicking → improvisation |
| Cooking | knife skills + five base techniques → one cuisine's repertoire → sauces → improvising from what's in the fridge |

Bad slices: "the first third of the textbook", "everything at a beginner level", "the theory before the practice". These leave nothing demonstrable and are the shape a course takes just before it's abandoned.
