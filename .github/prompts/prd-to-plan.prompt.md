---
name: prd-to-plan
description: Convert a product requirement into a prioritized implementation plan with vertical slices
---

Convert the described requirement into a concrete implementation plan.

## Step 1 — Clarify Before Planning
Ask these questions if the answers aren't obvious:
- What is the exact user-facing outcome? (observable behavior, not internal state)
- What is explicitly out of scope?
- Are there dependencies on other systems or teams?
- What is the definition of done?

## Step 2 — Identify Vertical Slices
Break the requirement into vertical slices — each slice:
- Delivers working, testable functionality end-to-end
- Can be shipped independently
- Has clear acceptance criteria

Avoid horizontal slices (e.g. "build all models first, then all APIs, then all UI").

## Step 3 — Sequence by Risk
Order slices to:
1. Validate the riskiest assumption first
2. Establish the data model before building on top of it
3. Keep the main branch deployable at each step

## Step 4 — Output Format
For each slice:
```
### Slice N: [name]
What it delivers: [user-visible outcome]
Acceptance criteria:
  - [ ] ...
  - [ ] ...
Files to create/modify: [list]
Estimated complexity: [S / M / L]
Depends on: [prior slice or external dep]
```

## Step 5 — Flag Risks
List any assumptions that if wrong would invalidate the plan. Note what would need to change.
