# PRDAY-style coaching member view

Use when a member-facing program page must display staff-authored coaching programs assigned to selected members.

## Session lesson

After the coach/admin authoring and assignment flow exists, the member page should stop assuming the old strength-session schema is the primary UI. The correct minimal viewer is read-only and assignment-driven.

## Minimal implementation shape

- Query `coaching_program_assignments` for the current `profile_id` + `box_id`.
- Fetch every assigned `programs` row that is not archived and in the assignment ids. In this product, assignment itself is the visibility signal; draft-but-assigned programs must still be member-visible unless archived.
- Do not `.limit(1)` unless the product explicitly says members can only have one program.
- Fetch related `program_days` for all assigned programs and group by `program_id`.
- Show category cards for `personal_training`, `diet_basic`, `hyrox`.
- For member-facing week lists, hide placeholder weeks that only have auto-generated titles. A week is member-visible only when it has at least one authored field: `goal`, `warmup`/content, or `coach_note`. Count/display visible weeks, not `programs.total_weeks`, or a 1-week authored program with 4 precreated rows will look like 4 weeks.
- In detail, show only those authored weeks:
  - program title / description
  - week number + week title
  - `goal` as “이번 주 목표”
  - `warmup` or equivalent content as “운동/관리 내용”
  - `coach_note` as “코치 코멘트”
- Include a clear empty state when no assignment exists or no authored weeks exist.

## Pitfalls

- Do not keep a legacy exercise-log/1RM/session-progress UI as the only member view when the new authoring flow writes freeform week goals/content/comments.
- Avoid adding comments, graphs, or completion tracking in the same pass unless requested; first prove the assigned content is visible.
- Keep the route protected: unauthenticated `/program` should still redirect/login as before.

## Verification

Run at minimum:

```bash
npm run typecheck
npx eslint 'src/app/(member)/program/page.tsx' --max-warnings=0
npm run build
```

After deploy, confirm the protected production route returns login for anonymous access:

```bash
curl -L -o /tmp/prday-program.html -w 'status=%{http_code} final=%{url_effective} size=%{size_download}\n' https://prday.app/program
```
