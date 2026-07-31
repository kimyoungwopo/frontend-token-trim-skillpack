# Frontend Token Trim Skillpack

A Hermes Agent skillpack for frontend work that installs:

- `ponytail` — minimal correct implementation, reuse existing code, no unrequested abstractions.
- `graphify` — narrow the code path before reading/editing broadly.
- `headroom` — keep context/output budget for verification and repair.
- `frontend-token-trim` — combined frontend workflow that loads the three behaviors together.

## Install

From this directory:

```bash
./install.sh
```

Or copy manually:

```bash
mkdir -p ~/.hermes/skills/software-development
cp -R skills/software-development/{ponytail,graphify,headroom,frontend-token-trim} ~/.hermes/skills/software-development/
```

Restart or start a new Hermes session after installing so the skill loader sees the new skills.

## Use

```txt
frontend-token-trim 적용해서 프론트엔드 작업해줘.
```

Compact delegation contract:

```txt
Apply Frontend Token Trim:
1) Graphify the narrow route/component/data/style path first.
2) Reuse existing components, hooks, API clients, styles, and tokens.
3) No new dependencies or broad refactors unless the current path proves they are necessary.
4) Touch the fewest files that fix the real flow.
5) Verify exact affected route plus 320/390 mobile overflow; include command/screenshot evidence.
6) Final report: changed files, verification result, remaining risk only.
```

## Notes

- Existing same-name skills are backed up by `install.sh` before replacement.
- `ponytail` is MIT-adapted from DietrichGebert/ponytail; see its SKILL.md.
