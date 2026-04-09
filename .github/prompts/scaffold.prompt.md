---
name: scaffold
description: Scaffold a new feature, module, or service — creates the skeleton with all required files
---

Scaffold the described feature, module, or service.

## Before Scaffolding
Answer these first (ask if not provided):
1. **What is this?** (API endpoint, service class, React component, CLI command, etc.)
2. **What does it do?** (single-sentence description)
3. **What does it receive/emit?** (inputs, outputs, events)
4. **What framework/pattern does the existing codebase use?** (check existing files first)

## Scaffold Checklist
Generate each of these in order:

### 1. Main module file
- The implementation file with correct structure for this project
- Types/interfaces defined at the top
- Exports at the bottom

### 2. Test file
- Co-located test file (`<module>.test.ts` or `test_<module>.py`)
- Placeholder tests for: happy path, empty/null input, error case
- Tests written as failing stubs — not implemented yet

### 3. Types / Schema (if applicable)
- Input/output type definitions
- Validation schema (zod / pydantic) if it touches a system boundary

### 4. Wire-up instructions
- Where to import and register this module
- Any config changes needed (env vars, routes, DI registration)

## Output Format
For each file, show:
```
// FILE: src/features/user/user-service.ts
<full file content>
```

After all files:
```
WIRE-UP:
1. Import UserService in app.ts
2. Register route in routes/index.ts: router.use('/users', userRouter)
3. Add env var: USER_SERVICE_URL=... (if needed)
```

## Constraints
- Match naming conventions in the existing codebase
- Only use packages already in package.json / requirements.txt
- Keep each file focused — no multi-responsibility modules
- Leave `// TODO: implement` in logic stubs — don't write fake implementations
