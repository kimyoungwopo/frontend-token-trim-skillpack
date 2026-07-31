# Frontend Token Trim Skillpack

**Ponytail + Graphify + Headroom for Hermes Agent frontend work.**

This skillpack helps frontend agents spend fewer tokens on broad repo browsing, speculative refactors, and verbose reports — while still preserving the checks that matter: source-path inspection, minimal diffs, mobile QA, and clear verification evidence.

## Why use it?

Frontend tasks get expensive when an agent:

- reads whole `app/`, `pages/`, or `components/` trees before knowing the real path,
- creates new components/hooks/tokens when the repo already has the pattern,
- turns a one-screen fix into a design-system rewrite,
- pastes long logs/diffs into the chat instead of summarizing evidence,
- runs out of context before mobile/browser verification.

This pack changes the workflow to:

```txt
Find the narrow path → reuse existing code → make the smallest correct diff → save headroom for QA → report only evidence/risk
```

## What gets installed?

| Skill | Role | What it prevents |
|---|---|---|
| `ponytail` | Minimal correct implementation: YAGNI, reuse existing code, native/platform features first, no unrequested abstractions. | Over-engineering, new dependencies, broad refactors, duplicate helpers. |
| `graphify` | Builds a small code-path map before reading/editing: `route → component → data/style dependency → QA target`. | Reading unrelated files, fixing the wrong layer, losing the real flow. |
| `headroom` | Compresses discovery/output and reserves context for verification and repair. | Token blowups from raw logs, giant diffs, premature essays, no room for QA. |
| `frontend-token-trim` | Combined frontend workflow that applies the three skills together. | Manual coordination between the three behaviors. |

## Best fit

Use this for:

- frontend bug fixes,
- UI polish,
- responsive/mobile repairs,
- route or component implementation,
- API-backed frontend flows,
- code review where context cost matters,
- Discord/Hermes frontend tasks where the final answer should be concise Korean evidence.

Do **not** use it as an excuse to skip:

- source inspection,
- accessibility basics,
- auth/security/data-integrity checks,
- lint/type/build/test gates,
- browser or mobile QA when the task is visual.

## The combined loop

### 1. Graphify — narrow the path first

Before editing, map the smallest connected path:

```txt
route/page → component → hook/API/state → style/token → QA target
```

Example:

```txt
/app/(member)/program/page.tsx → ProgramViewer → useAssignedPrograms → program card CSS → /program at 390px
```

This tells the agent which files deserve context and which files are noise.

### 2. Ponytail — smallest correct diff

After the path is known, the agent applies the minimalism ladder:

1. reuse/delete before adding,
2. existing component/token/hook before new one,
3. native HTML/CSS before JS/dependency,
4. local patch before broad refactor,
5. abstraction only when two real call sites need it now.

### 3. Headroom — keep budget for verification

The agent avoids raw dumps and saves context for the end of the task:

- command results,
- failing test names or first actionable error,
- browser route/viewport checks,
- mobile overflow evidence,
- remaining risk.

Preferred final report shape:

```txt
완료: <사용자 관점 결과>
변경: <핵심 파일/동작>
검증: <명령/브라우저/뷰포트 + 결과>
리스크: <없음 또는 남은 제한>
```

## Example prompt

Use this in Hermes:

```txt
frontend-token-trim 적용해서 이 프론트엔드 이슈 고쳐줘.
```

Or paste the explicit contract when delegating to another coding agent:

```txt
Apply Frontend Token Trim:
1) Graphify the narrow route/component/data/style path first.
2) Reuse existing components, hooks, API clients, styles, and tokens.
3) No new dependencies or broad refactors unless the current path proves they are necessary.
4) Touch the fewest files that fix the real flow.
5) Verify exact affected route plus 320/390 mobile overflow; include command/screenshot evidence.
6) Final report: changed files, verification result, remaining risk only.
```

## Before / after

### Without this pack

```txt
Read many files → infer architecture loosely → add a new component/helper → run one check → long summary
```

Common result: more context, more files touched, higher chance of missing mobile or existing project patterns.

### With this pack

```txt
Search visible route/copy → map one-hop dependencies → patch existing node → verify exact route/mobile → short evidence report
```

Common result: fewer files read, fewer files changed, clearer QA evidence.

## Install

### Option A: clone and install

```bash
git clone https://github.com/kimyoungwopo/frontend-token-trim-skillpack.git
cd frontend-token-trim-skillpack
./install.sh
```

### Option B: install from an existing checkout

```bash
./install.sh
```

### Option C: manual copy

```bash
mkdir -p ~/.hermes/skills/software-development
cp -R skills/software-development/{ponytail,graphify,headroom,frontend-token-trim} ~/.hermes/skills/software-development/
```

After installing, start a **new Hermes session** so the skill loader sees the new skills.

## What `install.sh` does

- Installs skills into:

```txt
~/.hermes/skills/software-development/
```

- Backs up existing same-name skills before replacing them:

```txt
<skill>.backup-YYYYMMDD-HHMMSS
```

- Supports a custom destination via:

```bash
HERMES_SKILLS_DIR=/path/to/skills/software-development ./install.sh
```

## Verify installation

In a new Hermes session, ask:

```txt
frontend-token-trim 스킬 로드해줘
```

Expected installed skills:

```txt
ponytail
graphify
headroom
frontend-token-trim
```

## Repository layout

```txt
skills/software-development/
  ponytail/
    SKILL.md
    references/
  graphify/
    SKILL.md
  headroom/
    SKILL.md
  frontend-token-trim/
    SKILL.md
install.sh
README.md
LICENSE
```

## Notes

- `ponytail` is MIT-adapted from DietrichGebert/ponytail; see `skills/software-development/ponytail/SKILL.md`.
- `graphify`, `headroom`, and `frontend-token-trim` are Hermes Agent skills authored for this pack.
- This pack is intentionally process-focused. It does not change your model, pricing, or context window; it changes how the agent spends context during frontend work.

## License

MIT
