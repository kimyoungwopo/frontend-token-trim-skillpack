# Frontend Token Trim Skillpack

<p align="center">
  <strong>Ponytail + Graphify + Headroom for token-efficient frontend agents</strong>
</p>

<p align="center">
  <a href="https://github.com/kimyoungwopo/frontend-token-trim-skillpack/blob/main/LICENSE"><img alt="License: MIT" src="https://img.shields.io/badge/license-MIT-green.svg"></a>
  <img alt="Hermes Agent" src="https://img.shields.io/badge/Hermes%20Agent-skillpack-blue.svg">
  <img alt="Frontend" src="https://img.shields.io/badge/frontend-token--trim-111827.svg">
  <img alt="Languages" src="https://img.shields.io/badge/docs-KO%20%7C%20EN%20%7C%20JA-orange.svg">
</p>

<p align="center">
  <a href="docs/ko.md">한국어</a> ·
  <a href="docs/en.md">English</a> ·
  <a href="docs/ja.md">日本語</a>
</p>

---

## Overview

Frontend Token Trim is a Hermes Agent skillpack that installs four skills:

- **`ponytail`** — minimal correct implementation: reuse existing code, avoid unrequested abstractions, keep diffs small.
- **`graphify`** — map the narrow code path first: `route → component → data/style dependency → QA target`.
- **`headroom`** — compress discovery/output so context remains available for verification and repair.
- **`frontend-token-trim`** — the combined frontend workflow using all three behaviors.

It is designed for frontend bug fixes, UI polish, responsive repairs, API-backed screens, and code reviews where context cost matters.

```txt
Find the narrow path → reuse existing code → make the smallest correct diff → reserve headroom for QA → report evidence only
```

## Why it helps

| Common failure mode | Frontend Token Trim behavior |
|---|---|
| Reads whole folders before locating the real path | Searches route/copy/component and maps the dependency path first |
| Adds new helpers/components/tokens too early | Reuses existing components, hooks, API clients, styles, and tokens |
| Turns a small fix into a broad refactor | Touches the fewest files that fix the real flow |
| Spends context on raw logs and giant summaries | Compresses output and saves tokens for QA/repair |
| Claims done before visual/mobile checks | Reports command/browser/viewport evidence and remaining risk |

## Model / agent support

This pack is **model-agnostic**. The installer is for Hermes Agent skills, but the workflow prompt can be reused with code-capable agents.

| Environment / model family | Support | Usage |
|---|---|---|
| Hermes Agent | Native | Install with `./install.sh`, then load/use `frontend-token-trim`. |
| OpenAI / Codex-style coding agents | Prompt-compatible | Paste the contract into task or project instructions. |
| Anthropic / Claude-style coding agents | Prompt-compatible | Paste the contract into the task or project rules. |
| Google Gemini-style coding agents | Prompt-compatible | Paste the contract into task or repo instructions. |
| OpenCode / terminal coding agents | Prompt-compatible | Put the contract in the task prompt and keep verification commands explicit. |
| Non-tool chat models | Limited | Useful as a checklist, but savings are smaller without file/search/edit/test tools. |

Best results require file search, targeted file reads, file edits, lint/type/build/test execution, and browser/screenshot QA for visual frontend work.

## Install

```bash
git clone https://github.com/kimyoungwopo/frontend-token-trim-skillpack.git
cd frontend-token-trim-skillpack
./install.sh
```

Manual copy:

```bash
mkdir -p ~/.hermes/skills/software-development
cp -R skills/software-development/{ponytail,graphify,headroom,frontend-token-trim} ~/.hermes/skills/software-development/
```

Start a **new Hermes session** after installing so the skill loader sees the new skills.

## Use

Hermes:

```txt
frontend-token-trim 적용해서 이 프론트엔드 이슈 고쳐줘.
```

Portable agent contract:

```txt
Apply Frontend Token Trim:
1) Graphify the narrow route/component/data/style path first.
2) Reuse existing components, hooks, API clients, styles, and tokens.
3) No new dependencies or broad refactors unless the current path proves they are necessary.
4) Touch the fewest files that fix the real flow.
5) Verify exact affected route plus 320/390 mobile overflow; include command/screenshot evidence.
6) Final report: changed files, verification result, remaining risk only.
```

## Documentation

- [한국어 설명](docs/ko.md)
- [English documentation](docs/en.md)
- [日本語ドキュメント](docs/ja.md)

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
docs/
  ko.md
  en.md
  ja.md
install.sh
README.md
LICENSE
```

## Notes

- Existing same-name skills are backed up by `install.sh` as `<skill>.backup-YYYYMMDD-HHMMSS`.
- `ponytail` is MIT-adapted from DietrichGebert/ponytail; see `skills/software-development/ponytail/SKILL.md`.
- This pack does not change your model, pricing, or context window. It changes how the agent spends context during frontend work.

## License

MIT
