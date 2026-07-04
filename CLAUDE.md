# Global Claude Instructions

## CRITICAL RULES

**NEVER enter plan mode (EnterPlanMode) unless the user EXPLICITLY asks for it.** Just do the work directly.

**NEVER ask the user to run commands. ALWAYS run commands yourself.**
If you need a password, API key, or any credential, use AskUserQuestion to request it directly.

**Sudo password:** stored in ~/.env as SUDO_PASSWORD

**NEVER pin a dependency version from memory.** Versions I "remember" are stale by definition and can predate critical security patches. When scaffolding or adding any dependency:
- Resolve the CURRENT latest stable from the registry (`bun info <pkg> version` / npm registry) — do not hardcode a remembered version number.
- For anything internet-facing with a big attack surface (Next.js, React, web servers, parsers), confirm the version is at/above the known-CVE patch line before pinning it.
- Run `bun audit` after installing and before shipping; wire Dependabot/Renovate on repos that serve traffic.
- Treat any AI-suggested version string as "verify against current," never trusted. Prefer a caret range over a bare exact pin unless there's a reason, and monitor either way.

**Why this rule exists:** hub was scaffolded (2026-06-25, by Claude) with `next` exact-pinned to `15.3.1` — a version from training memory that predated the Dec 2025 **React2Shell** disclosure (CVE-2025-55182 / CVE-2025-66478, CVSS 10.0 unauthenticated RCE in the App Router). On 2026-07-01 an opportunistic scanner (found the host via CT logs) exploited it for full RCE inside the Next.js process: dropped an XMRig cryptominer and exfiltrated every secret in the env — including the leaked `SUDO_PASSWORD`, which gave root and put every `.env` on the box in scope. Fixed by upgrading to `next@15.5.20`. A single `bun audit` at build time would have caught it.

## Global Environment

Global secrets are in `~/.env` - source them or check there for API keys.

## Tech Stack

Default to **Bun** instead of Node.js.

- `bun <file>` instead of `node`
- `bun test` instead of jest/vitest
- `bun install` instead of npm/yarn/pnpm
- `bun run <script>` instead of npm run
- `bunx <pkg>` instead of npx
- Bun auto-loads .env, no dotenv needed

### Bun APIs

- `Bun.serve()` for HTTP/WebSocket servers (not express)
- `bun:sqlite` for SQLite (not better-sqlite3)
- `Bun.redis` for Redis (not ioredis)
- `Bun.sql` for Postgres (not pg)
- `Bun.file` for file I/O (not fs.readFile)
- `Bun.$\`cmd\`` for shell commands (not execa)

## Project Structure

```
~/dev/           # All projects live here
~/.env           # Global API keys and secrets
~/.claude/       # Claude instructions (symlink to this repo's CLAUDE.md)
```
