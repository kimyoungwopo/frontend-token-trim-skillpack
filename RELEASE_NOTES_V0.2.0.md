# v0.2.0

Adoption-focused update for Frontend Token Trim Skillpack.

## Added

- `scripts/doctor.sh` to verify install health, duplicate backup conflicts, templates, and manifest.
- `scripts/install-agent-rules.sh` to install Codex, Claude, OpenClaude, or generic rule files into a target project.
- `skillpack.json` manifest for package metadata, bundled skills, templates, and scripts.
- `ROADMAP.md` with the path toward presets, benchmark suite, analyzer, and v1.0.
- `docs/modes.md` for light, strict, and review modes.
- `docs/frontend-qa-checklist.md` for mobile/responsive/accessibility QA evidence.
- `docs/promotion.md` and social preview assets.
- `examples/mobile-overflow/` as a concrete frontend-token-trim example.

## Changed

- README top section now shows the problem, solution, install command, and benchmark earlier.
- Validation workflow now checks v0.2.0 adoption docs, scripts, manifest, examples, and social assets.

## Install

```bash
git clone https://github.com/kimyoungwopo/frontend-token-trim-skillpack.git
cd frontend-token-trim-skillpack
./install.sh
```

## Update

```bash
./update.sh
```
