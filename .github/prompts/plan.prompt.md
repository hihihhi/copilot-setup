---
name: plan
description: Plan a feature or change before writing any code — identify scope, risks, and verify steps
---

Plan the described feature or change. Do not write any code yet.

## Step 1 — Understand the Requirement
Restate the requirement in one sentence. Then:
- What is the exact expected behavior? (inputs → outputs)
- What are the boundary cases? (empty, null, max values, error states)
- What should NOT change? (scope boundaries)

If anything is unclear, ask before continuing.

## Step 2 — Inventory What Exists
Before proposing new code, identify:
- Which existing files/modules will be changed?
- Which existing functions/methods will be called or modified?
- Which database tables or data structures are affected?
- Are there existing tests that will need updating?

## Step 3 — Design
Describe the approach in plain English:
- What new functions/classes/modules will be created?
- What will be changed in existing code?
- How will data flow through the system?

If there are multiple approaches, compare them:
| Approach | Pros | Cons | Chosen? |
|----------|------|------|---------|
| A | ... | ... | |
| B | ... | ... | ✓ |

State which you recommend and why.

## Step 4 — Implementation Plan
Break it into ordered steps, each with a verify condition:
```
1. [what to do] → verify: [how to confirm it worked]
2. [what to do] → verify: [how to confirm it worked]
```

## Step 5 — Risk Assessment
- What could go wrong?
- What existing functionality could break?
- What tests should be added to prevent regression?

## Output
End with:
- **Estimated files to touch**: list them
- **Testing strategy**: unit / integration / manual
- **Ready to implement?** If yes, say "Approved to proceed." If blocked by a question, list the questions.
