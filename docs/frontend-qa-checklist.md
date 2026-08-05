# Frontend QA Checklist

[← README](../README.md) · [Modes](modes.md) · [Examples](examples.md)

Use this checklist when a frontend task changes visible UI.

## Required evidence

- [ ] Affected route/page is named.
- [ ] One-line graph is known: `route → component → data/style → QA target`.
- [ ] Changed files are necessary for the user-visible fix.
- [ ] Lint/type/build/test command ran, or the reason it could not run is stated.

## Mobile layout

- [ ] 320px viewport checked when compact/mobile risk exists.
- [ ] 390px viewport checked for common mobile width.
- [ ] `scrollWidth <= clientWidth` or visual evidence confirms no horizontal overflow.
- [ ] Long Korean/Japanese/English copy wraps without clipping.
- [ ] Touch targets remain usable, ideally 44px or larger.

## Interaction/accessibility

- [ ] Button/link labels are preserved.
- [ ] Keyboard focus path still works for changed controls.
- [ ] Focus-visible style was not removed.
- [ ] Loading, empty, and error states were not broken by the fix.
- [ ] Color contrast remains reasonable on changed surfaces.

## Design-system reuse

- [ ] Existing component variants were checked before adding a new component.
- [ ] Existing design tokens/classes were reused before custom values.
- [ ] No new dependency was added without current-path proof.

## Final report shape

```txt
Changed: <files>
Verified: <commands/viewports/screenshots>
Risk: <remaining narrow risk or none>
```
