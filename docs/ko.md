# Frontend Token Trim Skillpack — 한국어

[← README](../README.md) · [English](en.md) · [日本語](ja.md)

## 한 줄 설명

**Ponytail + Graphify + Headroom**을 합쳐서 프론트엔드 에이전트가 덜 읽고, 덜 고치고, 더 정확히 검증하게 만드는 Hermes Agent 스킬팩입니다.

## 무엇이 좋아지나요?

프론트엔드 작업에서 토큰은 보통 코드 작성보다 **불필요한 탐색·장문 로그·재작업**에서 많이 소모됩니다. 이 스킬팩은 작업 순서를 강제해서 토큰 누수를 줄입니다.

| 문제 | 개선 방식 |
|---|---|
| 실제 경로를 찾기 전에 `app/`, `components/`를 통째로 읽음 | route/copy/component 검색으로 좁은 코드 경로부터 만듦 |
| 기존 컴포넌트/훅/토큰을 못 보고 새로 만듦 | 기존 패턴 우선 재사용 |
| 작은 UI 수정이 큰 리팩터링으로 커짐 | 현재 플로우를 고치는 최소 파일만 수정 |
| 검색결과·로그·diff를 그대로 붙임 | 파일 맵과 핵심 에러만 압축 보고 |
| QA 전에 컨텍스트가 부족해짐 | 모바일/브라우저 QA용 headroom 확보 |

## 토큰 차이 비교

비교할 수 있습니다. 같은 프론트엔드 작업을 두 번 실행하세요.

```txt
A. baseline: 일반 프론트엔드 지시
B. frontend-token-trim: 같은 지시 + Frontend Token Trim contract
```

정확한 값은 provider/agent usage log의 input/output/total tokens를 쓰는 것이 가장 좋습니다. transcript만 있다면 대략 추정용 스크립트를 사용할 수 있습니다.

```bash
python3 scripts/estimate_tokens.py baseline-transcript.txt token-trim-transcript.txt
```

자세한 방법은 [Token Usage Benchmark](benchmark.md)를 참고하세요.

## 설치되는 스킬

### `ponytail`

- YAGNI
- 기존 코드 우선
- native HTML/CSS/platform feature 우선
- 새 dependency 최소화
- shortest correct diff

막아주는 것: 과설계, 중복 helper, 불필요한 abstraction, broad refactor.

### `graphify`

작업 전에 작은 코드 경로를 만듭니다.

```txt
route/page → component → hook/API/state → style/token → QA target
```

예시:

```txt
/app/(member)/program/page.tsx → ProgramViewer → useAssignedPrograms → program card CSS → /program at 390px
```

막아주는 것: 관련 없는 파일 읽기, 증상 leaf만 고치기, 잘못된 레이어 수정.

### `headroom`

검색결과·로그·최종 보고를 압축하고 검증/수정용 컨텍스트를 남깁니다.

최종 보고 기본형:

```txt
완료: <사용자 관점 결과>
변경: <핵심 파일/동작>
검증: <명령/브라우저/뷰포트 + 결과>
리스크: <없음 또는 남은 제한>
```

### `frontend-token-trim`

위 세 가지를 프론트엔드 작업 루프로 합친 스킬입니다.

## 언제 쓰나요?

- 프론트엔드 버그 수정
- UI polish
- 모바일/반응형 overflow 수정
- route/page/component 구현
- API-backed frontend flow
- 코드 리뷰
- Discord/Hermes에서 짧은 한국어 evidence report가 필요할 때

## 주의

이 스킬팩은 검증 생략용이 아닙니다. 다음은 여전히 필요합니다.

- 실제 코드 경로 확인
- 접근성: label, focus-visible, keyboard path, contrast, 44px touch target
- 인증/권한/API/RLS/data integrity 확인
- lint/type/build/test
- 시각 작업의 경우 browser + 320/390 mobile QA

## 모델/에이전트 지원

| 환경 | 지원 | 사용법 |
|---|---|---|
| Hermes Agent | Native | `./install.sh` 후 `frontend-token-trim` 로드 |
| OpenAI Codex / Codex CLI | `AGENTS.md` 지원 | `templates/AGENTS.md`를 프로젝트 루트의 `AGENTS.md`로 복사하거나 contract를 붙여넣기 |
| Claude Code / Claude-style | `CLAUDE.md` 지원 | `templates/CLAUDE.md`를 프로젝트 루트의 `CLAUDE.md`로 복사하거나 task/project rule에 붙여넣기 |
| OpenClaude / OpenClaude-style | `OPENCLAUDE.md` 지원 | `templates/OPENCLAUDE.md`를 프로젝트 루트의 `OPENCLAUDE.md`로 복사하거나 contract를 붙여넣기 |
| Google Gemini-style | Prompt-compatible | task/repo instructions에 contract 붙여넣기 |
| OpenCode / terminal agents | Prompt-compatible | task prompt에 contract + 검증 명령 명시 |
| Tool 없는 chat model | Limited | 체크리스트로는 유용하지만 자동 검증은 제한됨 |

## 설치

```bash
git clone https://github.com/kimyoungwopo/frontend-token-trim-skillpack.git
cd frontend-token-trim-skillpack
./install.sh
```

설치 후 새 Hermes 세션을 시작하세요.

### Codex / Claude에 적용

Codex와 Claude Code는 Hermes 스킬 설치 방식이 아니라 **repo rule 파일**로 적용합니다.

```bash
# Codex / OpenAI coding agents
cp templates/AGENTS.md /path/to/your-project/AGENTS.md

# Claude Code / Claude-style coding agents
cp templates/CLAUDE.md /path/to/your-project/CLAUDE.md

# OpenClaude / OpenClaude-style agents
cp templates/OPENCLAUDE.md /path/to/your-project/OPENCLAUDE.md
```

다른 에이전트에는 `templates/frontend-token-trim.md` 내용을 prompt에 붙여넣으면 됩니다.

## 사용 예시

```txt
frontend-token-trim 적용해서 이 프론트엔드 이슈 고쳐줘.
```

다른 에이전트용 contract:

```txt
Apply Frontend Token Trim:
1) Graphify the narrow route/component/data/style path first.
2) Reuse existing components, hooks, API clients, styles, and tokens.
3) No new dependencies or broad refactors unless the current path proves they are necessary.
4) Touch the fewest files that fix the real flow.
5) Verify exact affected route plus 320/390 mobile overflow; include command/screenshot evidence.
6) Final report: changed files, verification result, remaining risk only.
```
