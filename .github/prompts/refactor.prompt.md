---
name: refactor
description: Surgical refactoring — improve structure without changing behavior
---

Refactor the selected code.

## Rules
- Behavior must be identical before and after. Tests must pass before and after.
- Match existing style and conventions in the surrounding codebase.
- Do not add features, fix bugs, or improve error handling as part of this refactor.
- If you notice unrelated issues, list them separately — don't fix them.

## What to Look For
1. **Extract function** — block of code that does one coherent thing, give it a name
2. **Rename** — names that don't reflect what the thing actually does
3. **Remove duplication** — same logic appearing 3+ times (not 2)
4. **Simplify conditionals** — nested ifs that can be flattened, early returns
5. **Reduce coupling** — function that reaches into other modules' internals
6. **Remove dead code** — unreachable branches, unused variables/imports

## What NOT to Do
- Don't introduce abstractions for code used only once
- Don't change the public API signature without flagging it as a breaking change
- Don't add logging, error handling, or validation that wasn't there
- Don't reformat code that wasn't part of the change

## Deliver
1. Refactored code
2. One-sentence explanation of what changed and why
3. Confirmation that behavior is identical (or flag any observable difference)
4. List of unrelated issues noticed (but not fixed)
