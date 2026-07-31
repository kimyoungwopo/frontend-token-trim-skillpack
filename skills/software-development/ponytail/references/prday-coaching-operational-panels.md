# PRDAY coaching operational panels

Session lesson: after the PRDAY coaching MVP has authoring, assignment, member check-ins, and manager filters, the next useful frontend layer is not another broad dashboard. Add compact operational panels inside the existing manager screen using the records already fetched.

## Trigger

Use this when the user asks for PRDAY-style coaching manager improvements such as:

- `회원 그래프`
- unanswered-question handling / `미응답 질문`
- `활동 로그`
- `주차 작성 보기/수정 모드`
- `회원 배정 접힘 구조`

## Minimal implementation pattern

Keep it one client component/file if the current manager screen already owns the data.

1. Reuse existing `programs`, `members`, `weeks`, and `coaching_week_checkins` rows. Do not add tables for first-pass progress or logs.
2. Add tiny helpers, not new services:
   - `hasVisibleCheckin(checkin)` for done/note/question/feedback presence.
   - `sortCheckinsByPriority(a,b)` for unanswered question first, then other questions, done records, newest updates.
   - `formatShortDate(value)` for activity timestamps.
3. In the member/assignment panel, add a member progress card:
   - assigned member list from `program.assignedProfileIds`.
   - `doneCount / totalWeeks`, question count, unanswered count.
   - simple CSS progress bar; orange when unanswered questions exist, blue otherwise.
4. In the records panel, split into:
   - `답변 큐`: only `question && !coach_feedback`.
   - `전체 기록`: visible records excluding the unanswered queue to avoid duplication.
   - `활동 로그`: derive recent rows from checkin fields; no separate audit table for MVP.
5. Convert week authoring from always-editing to read-first:
   - default view shows title, goal, content, coach note.
   - `수정하기` opens the form.
   - `취소` returns to read mode.
6. Convert assignment from always-expanded to current-assignment-first:
   - show current names and count.
   - `배정 수정` toggles search/checkbox list and save button.

## Pitfalls

- Do not duplicate unanswered questions in both `답변 큐` and `전체 기록` unless the user explicitly wants all records in one list; duplicate cards make mobile records feel longer.
- Progress denominator should be at least `1` to avoid `NaN`/division-by-zero when weeks are missing.
- Use actual visible weeks or program total weeks consistently; PRDAY’s current manager uses `program.weeks.length || program.total_weeks`.
- If a top-level summary click needs to open a child mobile tab, lift panel state to the manager component instead of trying to imperatively poke the child.
- Keep logs derived for MVP. Add a durable event/audit table only when the product needs immutable history or cross-program reporting.

## Verification

For this class of frontend-only operational panel change:

```bash
npm run typecheck
npx eslint 'src/app/(manager)/manager/coaching/_components/coaching-program-manager.tsx' --max-warnings=0
npm run build
git diff --check
```

Then commit, push, watch Red/Blue/Deployment Readiness, verify Vercel success, and confirm the protected `/manager/coaching` route still redirects anonymous users to `/login`.
