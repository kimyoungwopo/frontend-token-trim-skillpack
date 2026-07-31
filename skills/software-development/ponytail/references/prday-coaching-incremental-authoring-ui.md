# PRDAY coaching incremental authoring + shared UI controls

Use when changing PRDAY-style coach-authored, member-visible coaching programs.

## Lessons from session

- Do not precreate or show empty member weeks as if they are authored content. `program_days` rows with only placeholder title like `2주차` are authoring scaffolds, not member content.
- Member `/program` should render only weeks with meaningful member-visible content:
  - `goal` non-empty, or
  - `warmup` / program content non-empty, or
  - `coach_note` non-empty.
- Program cards should count visible/authored weeks, not `programs.total_weeks`, when communicating what the member will actually see.
- New coaching programs should default to 1 week. Let the coach explicitly choose 4/6/8/12 if needed.
- Add an incremental coach workflow: `+ 다음 주차 추가` inserts `max(week_no)+1`, `day_no=1`, `title='{n}주차'`, then refreshes/selects the new week.
- Keep member hiding logic even when a new empty week is added; the new week becomes visible to members only after content is written.

## Shared UI pitfall

- Do not use native `<select>` for mobile-facing PRDAY manager forms when the project has shared select controls. On Android Chrome, native selects open a full OS picker that visually breaks the Toss-like UI.
- Prefer `@/components/ui/select` `Select` for app-styled dropdowns and `@/components/ui/button` `Button` for ordinary action buttons.
- Raw `<button>` is still acceptable for selection cards/tabs/rows when the element is semantically a card or tab and already has a distinct local selected state.

## Minimal verification

```bash
npm run typecheck
npx eslint 'src/app/(manager)/manager/coaching/_components/coaching-program-manager.tsx' 'src/app/(member)/program/page.tsx' --max-warnings=0
npm run build
```

After deploy, verify protected routes still redirect anonymous users:

```bash
curl -L -o /tmp/prday-manager-coaching.html -w 'status=%{http_code} final=%{url_effective} size=%{size_download}\n' https://prday.app/manager/coaching
curl -L -o /tmp/prday-program.html -w 'status=%{http_code} final=%{url_effective} size=%{size_download}\n' https://prday.app/program
```
