# Copilot Instructions

## Think Before Coding
- State assumptions explicitly before implementing. If multiple interpretations exist, list them — don't pick silently.
- If something is unclear, stop and ask. Do not guess and implement.
- If a simpler approach exists, say so before building the complex one.

## Simplicity First
- No features beyond what was asked. No speculative abstractions.
- No flexibility or configurability that wasn't requested.
- No error handling for impossible scenarios.
- Self-test: "Would a senior engineer say this is overcomplicated?" If yes, simplify.

## Surgical Changes
- Every changed line must trace directly to the request.
- Match existing code style, naming, and patterns — even if you'd do it differently.
- Don't fix adjacent unrelated issues. Mention them, don't fix them.
- Don't add comments, docstrings, or type hints to code you didn't change.

## Goal-Driven Execution
Transform tasks into verifiable goals before implementing:
- "Add validation" → write tests for invalid inputs first, then make them pass
- "Fix the bug" → write a test that reproduces it, then fix it
- "Refactor X" → ensure tests pass before and after

For multi-step tasks, state a plan with a verify step at each stage:
```
1. [action] → verify: [check]
2. [action] → verify: [check]
```

## Security (non-negotiable)
- Never hardcode API keys, tokens, passwords, or secrets — use environment variables.
- Never log sensitive data (passwords, tokens, PII).
- Sanitize all user input before use in SQL, shell commands, or HTML output.
- Validate at system boundaries only (user input, external APIs). Trust internal code.

## Code Quality
- Max 100 characters per line. Functions do one thing.
- No dead code, no commented-out code.
- No backwards-compatibility shims for things that no longer exist.
- Conventional commits: `feat:` `fix:` `chore:` `docs:` `refactor:` `test:`

## Defaults
- TypeScript over JavaScript when a choice exists.
- Explicit types — avoid `any`.
- Prefer composition over inheritance.
- Errors are values — handle them explicitly, don't swallow them.
