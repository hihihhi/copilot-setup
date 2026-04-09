---
name: debug
description: Systematic debugging — reproduce, isolate, fix, verify
---

Debug the described problem systematically.

## Step 1 — Reproduce
- What is the exact error message or symptom?
- What are the exact steps to reproduce it?
- Is it consistent or intermittent?
- When did it start? What changed?

## Step 2 — Isolate
Work backwards from the symptom:
1. What is the last point where the system behaved correctly?
2. What is the first point where it behaves incorrectly?
3. Narrow the failure to the smallest possible reproduction case

## Step 3 — Hypothesize
List 3–5 possible causes ranked by likelihood. For each:
- What evidence supports it?
- What single check would confirm or eliminate it?

## Step 4 — Test Hypotheses
Test the most likely hypothesis first. For each test:
- State what you expect to see if the hypothesis is correct
- State what you expect to see if it's wrong
- Run the test and report the actual result

## Step 5 — Fix
- Apply the minimal fix that addresses root cause (not symptoms)
- Explain why this fix works
- Note any side effects

## Step 6 — Verify
- The original reproduction case no longer fails
- No regressions in adjacent functionality
- Add a test that would have caught this bug

Never skip to Step 5. The fix is worthless if you haven't confirmed the root cause.
