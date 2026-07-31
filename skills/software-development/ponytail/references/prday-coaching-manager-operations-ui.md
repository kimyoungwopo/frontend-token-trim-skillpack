# PRDAY coaching manager operations UI follow-up

Session learning from tightening `/manager/coaching` after the initial authoring-first MVP.

## Trigger

Use this when a staff/manager-authored feature becomes hard to operate on mobile because the page shows too many records, forms, and secondary states at once.

## Durable UI pattern

After the base authoring/assignment/member-visibility path is working, make the manager page operational rather than merely CRUD-shaped:

1. Add status filters near the top of the manager list.
   - `전체`: all records.
   - `운영`: not archived and either published or assigned to at least one member.
   - `작성`: not archived and not yet operating/assigned.
   - `종료`: archived.
2. Keep the mobile list compact.
   - Use horizontal compact cards/chips on mobile.
   - Keep desktop sidebars/lists unchanged when they work well.
   - Show only title, category/status, assignment count, and urgent badges.
3. Turn summary metrics into actions when possible.
   - `답변 대기 N건` should not just display a number.
   - On click/tap: close create forms, select the first relevant program, and open the `기록`/checkins panel.
4. Sort work queues by urgency.
   - First: `question && !coach_feedback`.
   - Then: question exists.
   - Then: completion/check-in exists.
   - Then: latest `updated_at`.
5. Label urgent work in multiple places.
   - Program card: `답변 필요 N`.
   - Checkin panel header: `답변 필요 N` plus total count.
   - Individual item: `답변 필요` badge and mild visual highlight.

## Pitfalls

- Do not rely only on database `published` to mean active/operating when product behavior says assigned draft records are effectively in operation.
- Do not add more dashboard metrics before connecting existing metrics to the next manager action.
- Avoid keeping mobile-only panel state trapped inside child components if a top-level summary card needs to open a child panel; lift the panel state up.

## Verification

For PRDAY frontend changes, verify with:

```bash
npm run typecheck
npx eslint 'src/app/(manager)/manager/coaching/_components/coaching-program-manager.tsx' --max-warnings=0
npm run build
```

Then confirm GitHub Red/Blue Deploy Gate including Deployment Readiness, Vercel success, and production route response.