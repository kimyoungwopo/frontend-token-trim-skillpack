# Frontend Token Trim Skillpack — 日本語

<p align="center">
  <img src="../assets/frontend-token-trim-flow.svg" alt="Frontend Token Trim workflow: Graphify, Ponytail, Headroom, verified result" width="920">
</p>

<p align="center">
  <strong>フロントエンド系エージェントの無駄なトークン消費を減らすワークフロー</strong><br>
  <span>Graphify で経路を絞り · Ponytail で最小変更にし · Headroom で QA 余白を残します</span>
</p>

<p align="center">
  <a href="../README.md">README</a> ·
  <a href="ko.md">한국어</a> ·
  <a href="en.md">English</a> ·
  <a href="benchmark.md">Benchmark</a> ·
  <a href="benchmark-result-controlled.md">Result</a>
</p>

<p align="center">
  <img alt="Hermes Agent" src="https://img.shields.io/badge/Hermes%20Agent-native-2563eb.svg">
  <img alt="Codex" src="https://img.shields.io/badge/Codex-AGENTS.md-111827.svg">
  <img alt="Claude" src="https://img.shields.io/badge/Claude-CLAUDE.md-8b5cf6.svg">
  <img alt="OpenClaude" src="https://img.shields.io/badge/OpenClaude-OPENCLAUDE.md-f97316.svg">
  <img alt="Token reduction" src="https://img.shields.io/badge/controlled%20benchmark--80.1%25-22c55e.svg">
</p>

---

## 一言でいうと

**Ponytail + Graphify + Headroom** を組み合わせ、フロントエンド系エージェントが **読む量を減らし、変更量を減らし、検証をより正確にする** ための Hermes Agent スキルパックです。

<table>
<tr>
<td width="33%">

### Graphify

実装前に小さなコード経路を作ります。

```txt
route → component → data/style → QA
```

</td>
<td width="33%">

### Ponytail

既存コードと既存パターンを優先します。

```txt
existing first → smallest diff
```

</td>
<td width="33%">

### Headroom

ログ・報告を圧縮し、QA 用のコンテキストを残します。

```txt
evidence > long summary
```

</td>
</tr>
</table>

## クイックスタート

### Hermes Agent

```bash
git clone https://github.com/kimyoungwopo/frontend-token-trim-skillpack.git
cd frontend-token-trim-skillpack
./install.sh
```

新しい Hermes セッションで次のように依頼します。

```txt
frontend-token-trim を適用して、このフロントエンド issue を修正してください。
```

### Codex / Claude / OpenClaude

プロジェクトルートに対応する rule file をコピーします。

```bash
# Codex / OpenAI coding agents
cp templates/AGENTS.md /path/to/your-project/AGENTS.md

# Claude Code / Claude-style agents
cp templates/CLAUDE.md /path/to/your-project/CLAUDE.md

# OpenClaude / OpenClaude-style agents
cp templates/OPENCLAUDE.md /path/to/your-project/OPENCLAUDE.md
```

## 何が良くなりますか？

| トークンが無駄になる箇所 | このスキルパックの対応 |
|---|---|
| 実際の経路を見つける前に `app/`, `components/`, `lib/` を広く読む | route/copy/class 検索で狭い経路を先に作る |
| 既存 component/hook/token を見落として新しく作る | 既存プロジェクトパターンを優先する |
| 小さな UI 修正が大きなリファクタになる | 実際の flow を直す最小ファイルだけ触る |
| 検索結果・ログ・diff が長くなりすぎる | ファイルマップと重要な証拠だけに圧縮する |
| モバイル QA 前にコンテキストが足りなくなる | 320/390px 検証用の headroom を残す |

## 制御ベンチマーク

<p align="center">
  <strong>局所的な mobile overflow task での結果</strong>
</p>

| モード | 推定トークン | 読んだファイル | 変更ファイル | 検証 |
|---|---:|---:|---:|---|
| 通常 baseline | 2,489 | 38 | 1 | lint, 390px browser |
| Frontend Token Trim | 496 | 4 | 1 | lint, 320px + 390px browser |

<p align="center">
  <img alt="Token reduction" src="https://img.shields.io/badge/token%20reduction-80.1%25-22c55e?style=for-the-badge">
</p>

詳しい方法:

- [Token Usage Benchmark](benchmark.md)
- [Controlled Benchmark Result](benchmark-result-controlled.md)

自分で推定する場合:

```bash
python3 scripts/estimate_tokens.py baseline-transcript.txt token-trim-transcript.txt
```

> 実際の課金トークンは model/tokenizer によって変わります。可能であれば provider または agent usage log を基準にしてください。

## インストールされるスキル

| スキル | 役割 | 防ぐもの |
|---|---|---|
| [`ponytail`](../skills/software-development/ponytail/SKILL.md) | 最小の正しい実装 | 過剰設計、新規依存、不要な抽象化 |
| [`graphify`](../skills/software-development/graphify/SKILL.md) | コード経路の絞り込み | repo-wide browsing、間違った層の修正 |
| [`headroom`](../skills/software-development/headroom/SKILL.md) | コンテキスト/出力予算管理 | 長いログ、長文報告、QA 余白不足 |
| [`frontend-token-trim`](../skills/software-development/frontend-token-trim/SKILL.md) | 3スキル統合 frontend loop | 焦点のぼけた frontend 作業ループ |

## モデル / エージェント対応

| 環境 | 対応 | 適用方法 |
|---|---|---|
| Hermes Agent | Native skillpack | `./install.sh` |
| OpenAI Codex / Codex CLI | Repo rules | `templates/AGENTS.md` |
| Claude Code / Claude-style | Repo rules | `templates/CLAUDE.md` |
| OpenClaude / OpenClaude-style | Repo rules | `templates/OPENCLAUDE.md` |
| Gemini-style coding agents | Prompt-compatible | `templates/frontend-token-trim.md` を貼る |
| OpenCode / terminal agents | Prompt-compatible | contract + 検証コマンドを明記 |
| Tool なし chat model | Limited | チェックリストとしては有用、自動検証は限定的 |

## Portable contract

```txt
Apply Frontend Token Trim:
1) Graphify the narrow route/component/data/style path first.
2) Reuse existing components, hooks, API clients, styles, and tokens.
3) No new dependencies or broad refactors unless the current path proves they are necessary.
4) Touch the fewest files that fix the real flow.
5) Verify exact affected route plus 320/390 mobile overflow; include command/screenshot evidence.
6) Final report: changed files, verification result, remaining risk only.
```

## 注意

- トークン削減は検証省略ではありません。
- accessibility、auth/permission、data integrity、lint/type/build/test は引き続き必要です。
- 視覚作業では browser + 320/390px mobile QA まで確認して初めて意味があります。
