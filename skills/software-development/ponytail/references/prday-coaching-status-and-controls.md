# PRDAY coaching: status labels, shared controls, and weekly authoring pitfalls

Session lessons from iterating on `/manager/coaching` and member-visible `/program`.

## Status label pitfall

Do not show every non-`published` coaching program as `작성 중`.

Current product semantics:

- `archived` → `종료`
- `published` → `공개`
- `draft` + assigned members > 0 → `배정됨`
- `draft` + assigned members = 0 → `작성 중`

Reason: member views intentionally show assigned non-archived programs, including draft rows, so a draft with assignments is already operational for selected members. Showing `작성 중` after assignment confuses the coach.

## Assignment should update status

When saving assignments for a coaching program:

- if selected profile count > 0, set `programs.status = 'published'`
- if selected profile count = 0, set `programs.status = 'draft'`
- revalidate `/manager/coaching`, `/member`, and `/program`

This keeps manager status badges, member dashboard cards, and member program pages in sync after assignment.

## Empty week pitfall

Creating placeholder `program_days` rows makes member screens look overfilled. Member `/program` should hide weeks with no meaningful member-facing content.

A safe visible-week predicate is:

```ts
Boolean(week.goal?.trim() || week.warmup?.trim() || week.coach_note?.trim())
```

The manager authoring screen can still show empty weeks for editing.

Default new coaching programs to 1 week. Let coaches add future weeks with a `+ 다음 주차 추가` flow instead of precreating 4 weeks.

## Shared UI controls

For manager coaching forms, avoid raw native `<select>` for mobile-facing controls such as `총 주차`; Chrome/iOS native pickers look inconsistent with PRDAY UI.

Use shared components:

```ts
import { Button } from "@/components/ui/button";
import { Select } from "@/components/ui/select";
```

Use shared `Button` for actual actions such as:

- 새 프로그램 / 목록 보기
- 프로그램 만들기
- 선택 회원 공개 / 공개 취소
- 종료
- 다음 주차 추가
- 주차 저장
- 피드백 저장
- 배정 저장

It is acceptable to keep raw `<button>` for selection-card or tab roles when they are not primary actions, for example category cards, program list cards, week tabs, and checkbox-style member rows.

## Verification pattern

For this class of frontend changes, run at least:

```bash
npm run typecheck
npx eslint 'changed files...' --max-warnings=0
npm run build
```

For WOD/PRDAY deploys, success reporting must include the full deploy gate, not just Vercel:

- GitHub Actions Red Team
- GitHub Actions Blue Team
- Deployment Readiness
- Vercel production success
- production route check, usually login redirect for protected routes
