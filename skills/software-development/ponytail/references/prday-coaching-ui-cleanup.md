# PRDAY coaching UI cleanup lessons

Session context: after implementing selected-member coaching programs, weekly check-ins, coach feedback, and week increment flow, the user flagged that both member and manager screens needed cleanup.

## Durable UI lessons

- Do not leave a member screen with duplicated summary/detail cards when the assigned item count is one. For `/program`, show the summary card grid only when there are multiple assigned programs; otherwise go straight to the detail view.
- Add compact progress/status summaries near the top of the detail view so the user can orient quickly before reading long weekly content. For member coaching this was: `주차 N개`, `완료 X/N`, and `피드백/질문 N건`.
- Manager screens that combine authoring, assignment, and feedback need a top-level operational summary before the dense editor. For coaching this was: active programs, assigned members, unanswered questions.
- Surface status in the selected manager detail header, not only in the left/list card. The user should not need to compare list and detail to understand whether a program is `작성 중`, `배정됨`, `공개`, or `종료`.
- When rapidly shipping MVP screens, revisit information hierarchy immediately after functionality works: remove duplicate cards, add count/status summaries, and separate “authoring / assignment / check-in” concepts visually.

## Related implementation pattern

For PRDAY coaching MVP cleanup:

1. Member `/program`:
   - Hide the program summary grid when `programs.length === 1`.
   - Keep the grid only for multi-program navigation.
   - Compute program-local checkins from visible weeks and show compact progress pills.
2. Manager `/manager/coaching`:
   - Add a 3-card summary row under the page header.
   - Compute `activeProgramCount`, `assignedCount`, `unansweredQuestionCount` client-side from loaded props.
   - Reuse `programStatusLabel(program)` in both list and detail header.
3. Verify with changed-file eslint, full typecheck, and production build before deploy.

## Pitfall

A functionally correct MVP can still feel messy if summary cards, detail cards, assignment panels, and check-in panels all appear with the same visual weight. The next cleanup step should be tabs or collapsible sections for manager workflows: `작성`, `배정`, `체크인`.