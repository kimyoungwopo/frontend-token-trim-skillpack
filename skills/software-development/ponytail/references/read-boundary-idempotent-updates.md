# Read-boundary idempotent updates

Use this when a frontend page shows stale operational state that can be safely derived from time or existing records, and the user wants the UI to stop depending on a manual button.

## Pattern

1. Trace the existing page → query hook → API route → domain/data layer before adding a new job or UI state.
2. If the desired change is deterministic and idempotent, put it at the read boundary that already powers the screen.
   - Example class: “when reservation/class start time has passed, confirmed bookings should be checked in.”
   - The GET route can first reconcile eligible rows, then return the fresh list.
3. Keep the helper server-side, small, and reusable.
4. Preserve historical correctness: when backfilling time-derived state, store the business event time if that is what analytics expect, not merely `now`.
5. Add lightweight client refetch only for the live/current date or active window; avoid polling past/future views.
6. Verify with the repo’s standard checks (usually lint + build) and report real command output.

## Pitfalls

- Do not add a cron route first if the screen’s existing fetch path can idempotently reconcile the state; cron can be a later upgrade for background processing when no operator has the page open.
- Do not implement only a visual label. Persist the underlying state if downstream stats/export depend on it.
- Do not weaken lint or introduce broad refactors while touching the flow.
