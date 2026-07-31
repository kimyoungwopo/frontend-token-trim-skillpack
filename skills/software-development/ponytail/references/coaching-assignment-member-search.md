# Coaching assignment member search: avoid over-narrow role filters

Session lesson from PRDAY coaching program management.

## Symptom

In a coach/manager assignment UI, searching for a known member returned “표시할 회원이 없습니다.” even though the person existed in member management. A later correction added that admin profiles must also appear because the user may operate as an admin while also receiving coaching.

## Root cause

The new feature queried `profiles` with an extra role constraint:

```ts
.eq("box_id", boxId)
.eq("role", "member")
```

Existing member-management APIs treated “members” as **box-scoped profiles**, then derived/member-filtered by operational status and membership data. Some legitimate members may have `role` null/legacy/different values. In PRDAY-style coaching, `admin`/`hq_admin` profiles can also be the athlete/assignee, so excluding staff roles can be just as wrong as requiring `role = 'member'`.

## Minimal fix pattern

For assignment candidate lists in this codebase:

1. Start from the same source shape as the existing member list: `profiles` scoped by `box_id`.
2. Do **not** require `role = 'member'`.
3. Do **not** exclude staff/admin/coach roles unless the product explicitly says those profiles can never be assigned. Ask/inspect the real flow first; PRDAY coaching allows admin-visible/assignable users.
4. Search across both `display_name` and `phone`, not name only.
5. After assignment exists, mirror the visibility boundary in member-facing surfaces: assigned programs should appear on both `/program` and the member dashboard (`/member`).

Example:

```ts
const { data: memberRows } = await supabase
  .from("profiles")
  .select("id, display_name, phone, avatar_url, role, is_coach")
  .eq("box_id", boxId)
  .order("display_name", { ascending: true });

const normalizedQuery = query.trim().toLowerCase();
const filtered = members.filter((member) => {
  if (!normalizedQuery) return true;
  const haystack = [member.display_name, member.phone].filter(Boolean).join(" ").toLowerCase();
  return haystack.includes(normalizedQuery);
});
```

## Regression probes

A small file-level assertion is enough for this class of bug:

```bash
python3 - <<'PY'
from pathlib import Path
page=Path('src/app/(manager)/manager/coaching/page.tsx').read_text()
comp=Path('src/app/(manager)/manager/coaching/_components/coaching-program-manager.tsx').read_text()
dashboard=Path('src/app/(member)/member/page.tsx').read_text()
assert '.eq("role", "member")' not in page
assert 'staffRoles' not in page
assert 'member.is_coach !== true' not in page
assert '[member.display_name, member.phone]' in comp
assert 'coaching_program_assignments' in dashboard
assert 'href="/program"' in dashboard
print('coaching assignment visibility checks passed')
PY
```

Then run the project gates for the touched files plus build before deploying.
