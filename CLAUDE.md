# Global Claude Instructions

## CRITICAL RULES

**NEVER ask the user to run commands. ALWAYS run commands yourself.**
If you need a password, API key, or any credential, use AskUserQuestion to request it directly.

**Sudo password:** stored in ~/.env as SUDO_PASSWORD

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
