---
applyTo: "**/api/**,**/routes/**,**/controllers/**,**/handlers/**"
---

# API Design Rules

- RESTful: nouns in URLs, HTTP verbs for actions. `/users/{id}` not `/getUser`.
- HTTP status codes used correctly: 200 OK, 201 Created, 204 No Content, 400 Bad Request, 401 Unauthorized, 403 Forbidden, 404 Not Found, 409 Conflict, 422 Unprocessable Entity, 500 Internal Server Error.
- All request bodies validated before processing — never trust incoming data.
- Error responses: consistent shape `{ error: { code, message, details? } }`.
- No stack traces in production error responses.
- Authentication checked before authorization. Authorization checked before business logic.
- Pagination for any endpoint that can return multiple items — cursor-based preferred over offset.
- Idempotent endpoints where possible (PUT/PATCH/DELETE should be safe to retry).
- Rate limiting headers in responses: `X-RateLimit-Limit`, `X-RateLimit-Remaining`.
- Never expose internal IDs directly — use UUIDs or slugs in public APIs.
