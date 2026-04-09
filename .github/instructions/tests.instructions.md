---
applyTo: "**/*.test.*,**/*.spec.*,**/test/**,**/tests/**,**/__tests__/**"
---

# Test Writing Rules

- One assertion per test where possible. One concept per test always.
- Test names describe behavior, not implementation: "returns 404 when user not found" not "test getUserById".
- Arrange-Act-Assert structure. Separate each section with a blank line.
- No shared mutable state between tests — each test sets up its own state.
- Mock at the boundary (network, filesystem, time) — not at the logic layer.
- Tests must be deterministic — no random data, no time-dependent logic without mocking `Date`.
- Integration tests hit real dependencies (DB, filesystem) — don't mock what you're testing.
- Test the public API / observable behavior — not internal implementation details.
- If a test requires more than 10 lines of setup, extract a helper or factory function.
- Coverage is a floor, not a goal — 80% coverage with meaningful tests > 95% with trivial ones.
