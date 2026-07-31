# PRDAY coaching mobile UI compaction lessons

Session context: PRDAY coaching-program MVP gained manager authoring, member viewing, weekly check-ins, coach feedback, and assignment controls. The user later corrected that both member and manager screens were too long on mobile.

## Durable UI lessons

### Manager `/manager/coaching`

Avoid showing every operational panel vertically on mobile. A coaching admin screen can quickly stack:

- program summary cards
- program list
- program detail actions
- week authoring form
- member assignment/search
- current assigned members
- member check-ins/questions/feedback

On mobile this becomes unusably long. Prefer:

1. Keep the top metrics as compact mini-cards in one row.
   - Hide helper copy on mobile.
   - Use smaller labels/values and restore larger spacing on desktop.
2. In the selected program detail, split operational areas into mobile tabs or segmented buttons:
   - `작성` = week selector + week editor
   - `배정` = assignment search/list + current assigned members
   - `기록` = member check-ins/questions/coach feedback
3. Preserve desktop productivity by keeping the wider two-column layout at `xl` and only applying the one-panel-at-a-time behavior below that breakpoint.
4. Reduce default textarea heights on mobile authoring forms. Large `rows={7}` fields make the screen feel endless; use smaller defaults and let users expand/scroll naturally.

### Member `/program`

Avoid placing long editable check-in forms inline under every week by default.

Preferred mobile shape:

1. Show coaching content first: category, title, progress summary, week goal/content/coach note.
2. Render member check-in as a compact collapsed card by default:
   - no existing record: `이번 주 기록` + `기록` button
   - existing record: `기록 있음` or `수행 완료` + `수정` button
   - coach feedback remains visible even while the input form is collapsed
3. Expand the full form only when the member taps `기록`/`수정`.
4. Collapse again after a successful save.

## Pitfall

A functionally complete MVP can still fail mobile usability if every section is always expanded. For PRDAY coaching, treat mobile as a task-switching surface: show one task area at a time, not the full manager workspace.