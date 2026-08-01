# Contributing

Thanks for improving Frontend Token Trim Skillpack.

## What this repo accepts

Good contributions usually fit one of these buckets:

- clearer frontend token-saving rules
- safer Hermes skill packaging or install/update behavior
- better Codex, Claude, OpenClaude, or portable agent templates
- Korean, English, or Japanese documentation improvements
- benchmark methodology improvements that preserve QA
- fixes to broken links, scripts, workflows, or attribution

## Local validation

Run these before opening a PR:

```bash
bash -n install.sh
bash -n update.sh
bash -n scripts/sync-upstream-skills.sh
```

Then check markdown fences and required files:

```bash
python3 - <<'PY'
from pathlib import Path
fence = '`' * 3
for path in ['README.md', 'docs/ko.md', 'docs/en.md', 'docs/ja.md', 'NOTICE.md']:
    text = Path(path).read_text()
    assert text.count(fence) % 2 == 0, path
for path in [
    'skills/software-development/ponytail/SKILL.md',
    'skills/software-development/graphify/SKILL.md',
    'skills/software-development/headroom/SKILL.md',
    'skills/software-development/frontend-token-trim/SKILL.md',
    'templates/AGENTS.md',
    'templates/CLAUDE.md',
    'templates/OPENCLAUDE.md',
]:
    assert Path(path).exists(), path
PY
```

## Skill change review rules

Skill text changes can change agent behavior. For PRs that edit `skills/` or `templates/`:

- explain what behavior should change
- keep the diff narrow
- preserve license and attribution
- do not weaken verification, mobile QA, or security/data-integrity checks
- update Korean, English, and Japanese docs when user-facing behavior changes

## Benchmark claims

Do not add broad savings claims without a method. A valid benchmark note should include:

- exact task or controlled transcript setup
- tokenizer or provider usage source
- files read and files changed
- checks run
- proof that QA was not skipped
