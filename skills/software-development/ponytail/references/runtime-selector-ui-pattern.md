# Runtime Selector UI Pattern

Use when adding a frontend control that switches an execution/runtime backend (for example API loop vs embedded app-server) in an existing app.

## Minimal durable pattern

1. **Reuse the existing command path.** If a slash command/CLI/shared helper already validates and persists the runtime, wrap that from the REST/UI endpoint instead of writing config directly. This preserves health checks, migration hooks, and user-facing warnings.
2. **Expose runtime in existing info payloads.** Add small fields such as `openai_runtime` / `api_mode` to the current model/session info responses instead of creating a parallel polling route.
3. **Make changes next-session by default.** Runtime swaps often change agent-loop ownership, prompt cache, approvals, and transcript semantics. Persist the choice but keep live sessions on their cached runtime unless the existing runtime layer explicitly supports hot-swap.
4. **Show a tiny badge where users already look.** Add `API` / `Codex` (or equivalent) beside the existing model pill/status rather than a new global panel.
5. **Use the existing settings page.** A small selector with one sentence of guidance beats a new wizard: default runtime, opt-in runtime, and "applies to new sessions".
6. **Verify both layers.** Add/adjust backend endpoint tests plus targeted frontend typecheck/component tests. For runtime integrations, also run the existing transport/integration tests that prove the alternate runtime still starts.

## Pitfalls

- Do not let two runtimes jointly own the same turn. Runtime choice is a session/request boundary, not an intra-turn mixer.
- Do not bypass the existing shared toggle logic; direct config writes silently skip binary checks, migrations, or warnings.
- Do not add broad abstractions first. The smallest robust diff is usually: info fields + one REST wrapper + one settings selector + one status badge.
