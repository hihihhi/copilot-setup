---
applyTo: "**/Dockerfile*,**/docker-compose*.yml,**/.dockerignore"
---

# Docker Rules

- Pin base image versions — `node:20-alpine` not `node:latest`.
- Multi-stage builds: separate build and runtime stages.
- Non-root user in production images — add `USER node` or equivalent.
- `.dockerignore` must exclude: `node_modules/`, `.git/`, `*.env`, `dist/`, `coverage/`.
- `COPY` specific files/dirs — avoid `COPY . .` without a tight `.dockerignore`.
- `ENV` for configuration that varies by environment. Secrets via runtime env vars, not `ENV`.
- Health checks defined for all service containers (`HEALTHCHECK` instruction).
- No `EXPOSE` without a matching service binding in `docker-compose.yml`.
- Order Dockerfile instructions from least to most frequently changed for cache efficiency.
- `docker-compose.yml`: explicit service names, named volumes, resource limits (`mem_limit`).
