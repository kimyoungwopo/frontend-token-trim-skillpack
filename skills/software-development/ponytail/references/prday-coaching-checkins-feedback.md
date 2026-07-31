# PRDAY coaching check-ins and coach feedback

Session lesson from extending selected-member coaching beyond read-only program viewing.

## When to use

After PRDAY coaching authoring/assignment and member visibility exist, the next smallest useful product step is a weekly check-in loop:

1. Member marks a program week as done.
2. Member leaves a short execution note and question.
3. Coach sees check-ins in `/manager/coaching` and saves feedback.
4. Member sees the feedback back on `/program`.

This is the minimal interaction loop before charts, reminders, analytics, body-composition tracking, or notifications.

## Data model

Use one row per member per program day/week:

```sql
coaching_week_checkins
- id uuid primary key
- program_id references programs(id)
- week_day_id references program_days(id)
- box_id references boxes(id)
- profile_id references profiles(id)
- is_done boolean default false
- member_note text
- question text
- coach_feedback text
- created_at timestamptz
- updated_at timestamptz
- unique (week_day_id, profile_id)
```

`week_day_id + profile_id` is the natural upsert key. Do not add a separate status table or comments thread until the product actually needs multiple messages per week.

## Permission boundary

For selected-member coaching, assignment is the member permission boundary:

- Member can manage only their own check-in rows.
- Member must have a matching `coaching_program_assignments` row for the program.
- Coach/manager/hq admin can read box check-ins and update `coach_feedback` for same-box rows.
- Keep archived program hiding on the read side; do not treat `published` as the member visibility boundary unless product direction changes.

## Server actions

Add small server actions rather than API routes when the surrounding app already uses server actions:

- `saveCoachingWeekCheckin({ programId, weekDayId, isDone, memberNote, question })`
- `saveCoachFeedback(checkinId, feedback)`

Both should revalidate the relevant surfaces (`/program`, `/member`, `/manager/coaching`). Validate box, assignment, and week/program relationship server-side; do not trust client IDs.

## UI placement

Member `/program`:

- Put the check-in form directly under each week card.
- Show a small `완료` badge when `is_done` is true.
- Show `코치 피드백` inside the same week card when present.

Manager `/manager/coaching`:

- Put a compact `회원 체크인` panel near assignment/current-member context.
- Show member name, week number, done state, note, question, and a feedback textarea.
- Keep it as a simple list first; add filters/notifications only after check-in volume makes them necessary.

## Verification

Minimum checks:

```bash
npm run typecheck
npx eslint '<changed files>' --max-warnings=0
npm run build
```

If the feature adds a table, verify whether this repo/environment can actually apply migrations. If not, hand the SQL to the user before deploying code that queries the new table.
