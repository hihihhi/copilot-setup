---
name: explain
description: Explain selected code — what it does, why it does it, and where it fits in the system
---

Explain the selected code. Calibrate depth to complexity — a 5-line helper needs 3 sentences; a 200-line module needs structured breakdown.

## What It Does
Plain English description of the code's purpose. Lead with the outcome:
"This function/class/module **[does X]** so that **[Y can happen]**."

## How It Works
Walk through the logic step by step:
1. **Input**: what does it receive? What are valid vs invalid inputs?
2. **Processing**: what transformations or decisions happen?
3. **Output / side effects**: what does it return or change?

For complex control flow (loops, branches, recursion), trace through a concrete example.

## Why It's Designed This Way
If the implementation has non-obvious choices:
- Why this data structure instead of the obvious one?
- Why this algorithm instead of a simpler one?
- What constraints is it working around?

If the code has known limitations or trade-offs, say so.

## Dependencies & Context
- What does this code depend on? (functions called, modules imported)
- Who calls this code? (where is it used in the system)
- What would break if this code changed?

## What's Unclear or Potentially Problematic
Be honest:
- Any parts that are hard to understand even after analysis?
- Any patterns that look like they could cause bugs?
- Any edge cases that appear unhandled?

## One-Line Summary
End with: "**TL;DR**: [one sentence that captures the essence]"
