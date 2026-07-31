# Frontend Token Trim Skillpack

**Ponytail + Graphify + Headroom for token-efficient frontend agents.**

A Hermes Agent skillpack that helps frontend agents spend fewer tokens on broad repo browsing, speculative refactors, and verbose reports — while still preserving the checks that matter: source-path inspection, minimal diffs, mobile QA, and clear verification evidence.

Languages: [한국어](#한국어) · [English](#english) · [日本語](#日本語)

---

## 한국어

### 무엇인가요?

`frontend-token-trim`은 프론트엔드 작업에서 **토큰을 아끼면서도 검증 품질은 낮추지 않기 위한 스킬 묶음**입니다.

핵심 흐름은 단순합니다.

```txt
좁은 코드 경로 찾기 → 기존 코드 재사용 → 최소 diff 수정 → QA용 컨텍스트 남기기 → 증거 중심 보고
```

### 왜 쓰나요?

프론트엔드 작업에서 토큰이 많이 새는 원인은 보통 이렇습니다.

- 실제 경로를 찾기 전에 `app/`, `pages/`, `components/` 전체를 읽음
- 이미 있는 컴포넌트/훅/토큰을 못 보고 새로 만듦
- 한 화면 수정이 디자인 시스템 리팩터링으로 커짐
- 긴 로그/검색결과/diff를 그대로 채팅에 붙임
- 마지막 모바일/브라우저 QA 전에 컨텍스트가 부족해짐

이 스킬팩은 작업 방식을 다음처럼 바꿉니다.

| 기존 방식 | 이 스킬팩 사용 |
|---|---|
| 폴더 단위로 많이 읽음 | route/copy/component 검색으로 경로 먼저 좁힘 |
| 새 컴포넌트/훅을 쉽게 만듦 | 기존 패턴/토큰/훅 우선 재사용 |
| 넓은 리팩터링으로 번짐 | 현재 증상에 필요한 최소 파일만 수정 |
| 장문 요약 | 변경·검증·리스크만 짧게 보고 |
| QA가 뒤로 밀림 | 컨텍스트를 QA/수정용으로 남김 |

### 설치되는 스킬

| Skill | 역할 | 막아주는 문제 |
|---|---|---|
| `ponytail` | YAGNI, 기존 코드 우선, native/platform feature 우선, 최소 구현 | 과설계, 새 dependency, 중복 helper, broad refactor |
| `graphify` | `route → component → data/style dependency → QA target` 경로를 먼저 만듦 | 관련 없는 파일 읽기, 잘못된 레이어 수정 |
| `headroom` | 검색결과/로그/보고를 압축하고 QA용 컨텍스트 확보 | raw dump, 장문 설명, 검증 전 컨텍스트 고갈 |
| `frontend-token-trim` | 위 3개를 프론트엔드 작업 루프로 합침 | 매번 수동으로 세 규칙을 조합해야 하는 문제 |

### 언제 쓰면 좋나요?

- 프론트엔드 버그 수정
- UI polish
- 모바일/반응형 overflow 수정
- route/page/component 구현
- API-backed frontend flow
- 코드 리뷰에서 불필요한 컨텍스트를 줄이고 싶을 때
- Discord/Hermes에서 최종 보고를 짧은 한국어 증거 중심으로 받고 싶을 때

### 쓰면 안 되는 방식

이 스킬팩은 **검증 생략용이 아닙니다.** 다음은 여전히 해야 합니다.

- 실제 코드 경로 확인
- 접근성 기본값: label, focus-visible, keyboard path, contrast, 44px touch target
- 인증/권한/API/RLS/data-integrity 확인
- lint/type/build/test
- 시각 작업이면 브라우저 + 320/390 모바일 QA

### 사용 예시

Hermes에서:

```txt
frontend-token-trim 적용해서 이 프론트엔드 이슈 고쳐줘.
```

다른 코딩 에이전트에 붙여넣기:

```txt
Apply Frontend Token Trim:
1) Graphify the narrow route/component/data/style path first.
2) Reuse existing components, hooks, API clients, styles, and tokens.
3) No new dependencies or broad refactors unless the current path proves they are necessary.
4) Touch the fewest files that fix the real flow.
5) Verify exact affected route plus 320/390 mobile overflow; include command/screenshot evidence.
6) Final report: changed files, verification result, remaining risk only.
```

---

## English

### What is this?

`frontend-token-trim` is a skillpack for frontend agent work. It reduces token waste without lowering implementation or QA standards.

Core loop:

```txt
Find the narrow path → reuse existing code → make the smallest correct diff → reserve headroom for QA → report evidence only
```

### Why use it?

Frontend agent tasks often waste tokens when the agent:

- reads entire `app/`, `pages/`, or `components/` trees before locating the real path,
- creates new components/hooks/tokens even though the repo already has the pattern,
- turns a one-screen fix into a design-system refactor,
- pastes long logs/search results/diffs instead of compressing evidence,
- runs out of context before browser or mobile QA.

This pack shifts the workflow from broad exploration to narrow, verified execution.

| Default failure mode | With this pack |
|---|---|
| Read many folders | Search route/copy/component and map the path first |
| Add new abstractions | Reuse existing components, hooks, API clients, styles, and tokens |
| Broad refactor | Patch the fewest files that fix the real flow |
| Long final essay | Report changed files, verification, and remaining risk only |
| QA squeezed out | Reserve context for browser/mobile checks and repair |

### Installed skills

| Skill | Role | Prevents |
|---|---|---|
| `ponytail` | YAGNI, existing code first, native/platform features first, shortest correct diff | Over-engineering, new dependencies, duplicate helpers, broad refactors |
| `graphify` | Builds a small `route → component → data/style dependency → QA target` map before reading/editing | Unrelated file reads, wrong-layer fixes, lost flow |
| `headroom` | Compresses discovery/output and reserves context for verification and repair | Raw dumps, giant summaries, no room for QA |
| `frontend-token-trim` | Combines the three behaviors into a frontend workflow | Manual coordination between the three skills |

### Best fit

Use it for:

- frontend bug fixes,
- UI polish,
- responsive/mobile repairs,
- route or component implementation,
- API-backed frontend flows,
- code review where context cost matters,
- Hermes/Discord workflows where the final answer should be concise and evidence-based.

Do **not** use it to skip source inspection, accessibility, auth/security/data-integrity checks, build/test gates, or browser/mobile QA.

### Example prompt

```txt
Apply frontend-token-trim to this frontend issue.
```

Or use the explicit contract:

```txt
Apply Frontend Token Trim:
1) Graphify the narrow route/component/data/style path first.
2) Reuse existing components, hooks, API clients, styles, and tokens.
3) No new dependencies or broad refactors unless the current path proves they are necessary.
4) Touch the fewest files that fix the real flow.
5) Verify exact affected route plus 320/390 mobile overflow; include command/screenshot evidence.
6) Final report: changed files, verification result, remaining risk only.
```

---

## 日本語

### これは何ですか？

`frontend-token-trim` は、フロントエンド作業で **トークン消費を抑えながら、実装品質と検証品質を落とさない** ためのスキルパックです。

基本ループ:

```txt
狭いコード経路を見つける → 既存コードを再利用 → 最小diffで修正 → QA用の余白を残す → 証拠だけを報告
```

### 何が良くなりますか？

フロントエンド作業では、次のような理由でトークンが無駄になりがちです。

- 実際の経路を特定する前に `app/`, `pages/`, `components/` 全体を読む
- 既存のコンポーネント・hook・token があるのに新しく作る
- 1画面の修正が大きなリファクタリングになる
- 長いログ・検索結果・diff をそのまま貼る
- 最後のブラウザ/モバイルQA前にコンテキストが足りなくなる

このスキルパックは、作業を次の方向に変えます。

| よくある失敗 | このスキルパック使用時 |
|---|---|
| フォルダ単位で広く読む | route/copy/component 検索で経路を先に絞る |
| 新しい抽象化を追加する | 既存の component/hook/API/style/token を優先 |
| 広いリファクタリングになる | 実際のフローを直す最小ファイルだけ修正 |
| 長い最終説明 | 変更・検証・残リスクだけ報告 |
| QA が後回しになる | QA/修正用のコンテキストを残す |

### インストールされるスキル

| Skill | 役割 | 防ぐ問題 |
|---|---|---|
| `ponytail` | YAGNI、既存コード優先、native/platform feature 優先、最小実装 | 過剰設計、新規依存、重複 helper、大きすぎるリファクタ |
| `graphify` | `route → component → data/style dependency → QA target` の小さな経路を先に作る | 無関係なファイル読み、間違った層の修正 |
| `headroom` | 検索結果/ログ/報告を圧縮し、検証と修正のための余白を確保 | raw dump、長文説明、QA前のコンテキスト不足 |
| `frontend-token-trim` | 3つの動作をフロントエンド用ループとして統合 | 毎回3つのルールを手動で組み合わせる手間 |

### 使う場面

- フロントエンドのバグ修正
- UI polish
- モバイル/レスポンシブ修正
- route/page/component 実装
- API連携のあるフロントエンド flow
- コンテキストコストを抑えたいコードレビュー

これは検証を省略するためのものではありません。アクセシビリティ、認証/権限、lint/type/build/test、ブラウザ/モバイルQAは必要です。

### 使用例

```txt
frontend-token-trim を適用して、このフロントエンド issue を修正してください。
```

---

## Model / agent support

This pack is **model-agnostic**. It does not depend on a specific LLM vendor. The install script targets Hermes Agent skills, but the workflow prompt can be pasted into any code-capable agent.

| Environment / model family | Support level | How to use |
|---|---|---|
| **Hermes Agent** | Native | Install with `./install.sh`, then ask Hermes to load/use `frontend-token-trim`. |
| **OpenAI / Codex-style coding agents** | Prompt-compatible | Paste the explicit Frontend Token Trim contract into the task or project instructions. |
| **Anthropic / Claude-style coding agents** | Prompt-compatible | Paste the contract into the task or a project rule file. |
| **Google Gemini-style coding agents** | Prompt-compatible | Paste the contract into the task or repo instructions. |
| **OpenCode / other terminal coding agents** | Prompt-compatible | Put the contract in the task prompt; keep verification commands explicit. |
| **Non-tool chat models** | Limited | Useful as guidance, but token savings are smaller because the model cannot inspect files or verify QA directly. |

### Requirements for best results

The agent should be able to:

- search file contents,
- read targeted file windows,
- edit files,
- run lint/type/build/test commands,
- perform browser or screenshot QA for visual frontend work.

If an agent cannot run tools, use this pack as a short checklist rather than expecting full automatic behavior.

---

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
