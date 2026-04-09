---
name: tdd
description: Test-driven development — write failing tests first, then implement to pass them
---

Apply test-driven development to the described feature or fix.

## Process
1. **Red** — Write the minimum failing test(s) that describe the expected behavior
2. **Green** — Write the minimum implementation code to make the tests pass
3. **Refactor** — Clean up without changing behavior; tests must still pass

## Before Writing Any Code
State:
- What is the exact input?
- What is the exact expected output?
- What are the edge cases? (empty, null, boundary values, error states)
- What should NOT happen (negative cases)?

## Test Structure
```
describe('<unit under test>', () => {
  it('<expected behavior in plain English>', () => {
    // Arrange
    const input = ...

    // Act
    const result = ...

    // Assert
    expect(result).toBe(...)
  })
})
```

## Rules
- Write tests before implementation — not after
- Each test covers exactly one behavior
- Tests are independent — no shared mutable state
- Mock only at system boundaries (network, DB, filesystem, time)
- If you can't write a failing test for it, the requirement isn't clear enough — clarify first

## Deliver
1. Failing tests first (with explanation of what they test)
2. Implementation that makes them pass
3. Refactored version (if cleanup was needed)
