# Agent Setup

[← README](../README.md) · [Troubleshooting](troubleshooting.md)

## Hermes Agent

```bash
git clone https://github.com/kimyoungwopo/frontend-token-trim-skillpack.git
cd frontend-token-trim-skillpack
./install.sh
```

Start a new Hermes session and ask:

```txt
frontend-token-trim 적용해서 이 프론트엔드 이슈 고쳐줘.
```

## Codex / OpenAI coding agents

```bash
cp templates/AGENTS.md /path/to/your-project/AGENTS.md
```

Use it with a task like:

```txt
Follow AGENTS.md and apply Frontend Token Trim for this frontend fix.
```

## Claude Code / Claude-style agents

```bash
cp templates/CLAUDE.md /path/to/your-project/CLAUDE.md
```

## OpenClaude / OpenClaude-style agents

```bash
cp templates/OPENCLAUDE.md /path/to/your-project/OPENCLAUDE.md
```

## Other coding agents

Paste:

```txt
Apply Frontend Token Trim:
1) Graphify the narrow route/component/data/style path first.
2) Reuse existing components, hooks, API clients, styles, and tokens.
3) No new dependencies or broad refactors unless necessary.
4) Touch the fewest files that fix the real flow.
5) Verify exact affected route plus 320/390 mobile overflow.
6) Final report: changed files, verification result, remaining risk only.
```

## Important limitation

Only Hermes loads the bundled skills natively. Other agents use the rule files or portable prompt contract.
