---
applyTo: "**/api/**,**/routes/**,**/controllers/**,**/handlers/**,**/endpoints/**"
---

# API Design Rules

## URL Design
- Nouns in URLs, HTTP verbs for actions: `/users/{id}` not `/getUser`.
- Plural nouns for collections: `/users`, `/orders`, not `/user`, `/order`.
- Nested resources for tight ownership: `/users/{id}/orders` — but max 2 levels deep.
- Kebab-case in URLs: `/user-profiles` not `/userProfiles` or `/user_profiles`.
- Version in path: `/v1/users` — never in header (harder to test, harder to debug).

## HTTP Status Codes
Use the right code — not just 200 for everything:
```
200 OK            — successful GET, PUT, PATCH
201 Created       — successful POST that created a resource (include Location header)
204 No Content    — successful DELETE or action with no response body
400 Bad Request   — invalid input (validation failed)
401 Unauthorized  — not authenticated (missing/invalid token)
403 Forbidden     — authenticated but not authorized for this resource
404 Not Found     — resource doesn't exist
409 Conflict      — duplicate / state conflict (user already exists)
422 Unprocessable — semantically invalid (right shape, wrong values)
429 Too Many      — rate limited
500 Internal      — unexpected server error (never expose details)
```

## Request Validation
Validate before touching business logic:
```ts
// Pattern: schema.safeParse → 400 on failure → typed data on success
const parsed = CreateUserSchema.safeParse(req.body)
if (!parsed.success) {
  return res.status(400).json({
    error: { code: 'VALIDATION_ERROR', details: parsed.error.flatten() }
  })
}
// past this line, parsed.data is fully typed and safe
```

## Response Envelope
Consistent shape for all responses:
```ts
// Success
{ "data": { "id": "...", "email": "..." } }
{ "data": [...], "meta": { "cursor": "...", "hasMore": true } }

// Error
{ "error": { "code": "USER_NOT_FOUND", "message": "User abc was not found" } }
```
Never mix data and error in the same response. No stack traces in production errors.

## Authentication & Authorization Order
```
request → validate input → check auth token → check permission → execute logic
```
- Authentication: "who are you?" (JWT, session) — 401 if missing/invalid
- Authorization: "can you do this?" (RBAC, ownership) — 403 if not permitted
- Never check authorization before authentication

## Pagination
Prefer cursor-based over offset for any list that could be large:
```ts
// Cursor-based (stable under concurrent inserts/deletes)
GET /users?cursor=eyJpZCI6MTAwfQ&limit=20
{ data: [...], meta: { cursor: "eyJpZCI6MTIwfQ", hasMore: true } }

// Offset is acceptable for small, stable datasets (admin tables, dropdowns)
GET /users?page=2&limit=20
```

## Idempotency
- `GET`, `PUT`, `DELETE` should be safe to retry with the same result.
- `POST` is not idempotent by default — use idempotency keys for payment/order creation:
  `Idempotency-Key: <uuid>` in request header.

## IDs & Sensitive Data
- Public-facing IDs: UUID v4 — never expose sequential auto-increment IDs.
- Strip internal fields (`passwordHash`, `internalStatus`) from all responses.
- Rate limit headers in responses: `X-RateLimit-Limit`, `X-RateLimit-Remaining`, `X-RateLimit-Reset`.

## Error Response Codes
Use machine-readable `code` strings, not just HTTP status:
```
USER_NOT_FOUND, VALIDATION_ERROR, DUPLICATE_EMAIL,
INSUFFICIENT_PERMISSIONS, RATE_LIMITED, INTERNAL_ERROR
```
This allows clients to handle specific errors without parsing message strings.
