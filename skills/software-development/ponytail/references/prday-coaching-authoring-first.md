# Authoring-first MVP for assigned/member-visible features

Session lesson from PRDAY coaching-program implementation.

## Problem

For a member-visible feature that depends on coach/manager-authored data, starting with the member UX can produce attractive empty screens backed by fake/temporary data. The user corrected that the **coach area should be implemented first**.

## Rule of thumb

When a feature is about selected users seeing content assigned by staff/coaches/admins, implement the smallest authoring/assignment path first:

1. Staff/coach/admin creates the record.
2. Staff/coach/admin fills the minimum required content.
3. Staff/coach/admin assigns selected members/users.
4. Member view reads only assigned records and hides archived records; do not add a stricter `published` filter unless the product explicitly says draft means staff-only.
5. Then add comments, records, graphs, and analytics.

This verifies the core permission boundary early: **selected users only**.

## PRDAY concrete mapping

For PRDAY coaching-program work, Phase 1 should be:

- `/manager/coaching` program list/create
- category: `personal_training` / `diet_basic` / `hyrox`
- weekly free-text content: title, goal, program content, coach note
- selected-member assignment table
- publish/unpublish for selected members
- default new programs to 1 week unless the coach explicitly chooses a longer duration. Precreating 4+ placeholder week rows makes member screens look overfilled unless the viewer filters empty weeks.
- for the status-label/control details learned from the follow-up implementation, see `references/prday-coaching-status-and-controls.md`.

Defer:

- member comments
- member record entry
- charts/radar/HYROX readiness visualization
- complex dashboard metrics
- payment/plan enforcement

## Minimalism note

Prefer reusing existing program tables when safe, adding only the columns/table needed for category + assignment. Do not introduce a new dependency or a full dashboard shell for this first pass.

## Mobile frontend follow-up lesson

When this class of staff-authored/member-visible feature grows beyond the first MVP, optimize mobile screens before adding more data blocks:

- Avoid long stacked manager pages. Split operational work into compact panels/tabs such as `작성 / 배정 / 기록` so only one task area is open on mobile.
- Put summary metrics in one-row mini cards on mobile; hide helper copy until tablet/desktop.
- Convert manager-side item lists to horizontal compact cards/chips on mobile while keeping desktop sidebars/lists.
- Collapse member-side input forms by default; show short status cards like `이번 주 기록`, `기록 있음`, `수행 완료`, with explicit `기록/수정` buttons.
- Truncate secondary descriptions on mobile; keep primary title, status, assigned count, and next action visible above the fold.
- Prefer reducing spacing, textarea rows, and explanatory text before introducing new UI abstractions or dependencies.
- Still verify with the full frontend gate: typecheck, lint for touched files, production build, GitHub Red/Blue/Deployment Readiness, Vercel status, and production route check.

## Manager-side lifecycle/filter pitfall

When adding manager filters such as `전체 / 운영 / 작성 / 종료`, make sure the server query feeds the lifecycle states the UI is expected to count. In the PRDAY coaching manager screen, `종료` stayed at `0` because the server page query still had `.neq("status", "archived")`; the frontend filter logic was correct but never received archived rows. For staff/manager views that provide an archived/ended filter, include archived records in the manager query and let the frontend filter them. Keep member-facing views hiding archived records.

Recommended behavior after a manager archives/ends a program:

1. Update status to `archived`.
2. Revalidate the manager path.
3. Switch the local UI to the `종료` filter so the item does not appear to vanish.
4. In archived detail views, replace active controls like `선택 회원 공개` / `종료` with a passive `종료된 프로그램` state.

## Manager mobile UX follow-up patterns

For staff authoring screens on mobile, the first viewport should prioritize operational scanning over full forms:

- Keep metrics compact and actionable; make `답변 대기` clickable when possible, routing to the first unanswered item and opening the records/checkins panel.
- Add lifecycle filter chips early (`전체 / 운영 / 작성 / 종료`) once there is more than one lifecycle state.
- For checkins/questions, sort `질문 있음 + 피드백 없음` first, then other questions, done records, and newest updates. Add `답변 필요` badges on the program card, records panel header, and individual checkin item.
- Collapse or compact create forms on mobile: category buttons as one-row chips/cards, title + week count in a single row, short textareas, hide helper copy, and prevent primary button labels from wrapping.
- After ending/archiving an item, navigate/filter to the ended list instead of leaving the user on an empty active list.