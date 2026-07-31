# PRDAY coaching member visibility pitfall

Session lesson from the PRDAY coaching-program rollout.

## Symptom

A member/admin profile was assigned to a coaching program in `/manager/coaching`, but nothing appeared on the member dashboard (`/member`) or member program page (`/program`).

## Root cause

The assignment row existed in `coaching_program_assignments`, but the assigned program was still `status = 'draft'`. The member surfaces filtered assigned programs with `status = 'published'`, so the assignment looked broken even though the assignment table was correct.

## Rule

For PRDAY selected-member coaching, **assignment is the visibility boundary**. Member surfaces should load assigned programs and hide only archived programs:

```ts
.from("programs")
.eq("box_id", profile.box_id)
.is("athlete_id", null)
.neq("status", "archived")
.in("id", assignedProgramIds)
```

Do not require `status = 'published'` on member surfaces unless the product explicitly redefines draft as staff-only.

## Manager UX implication

The manager button label `선택 회원 공개` can be misleading if assigned draft programs are still member-visible. If keeping draft visible for assigned members, treat status as lifecycle/state (`archived` hides) rather than the member visibility switch, or rename/copy the controls accordingly.

## Verification probe

Use a service-role or trusted DB probe without printing secrets:

1. Find target profile IDs and assignments in `coaching_program_assignments`.
2. Fetch assigned programs with `.neq("status", "archived")`.
3. Confirm `assignmentCount > 0` and `visibleCount > 0` for the affected profile.
4. Run `npm run typecheck`, changed-file eslint with `--max-warnings=0`, and `npm run build`.
