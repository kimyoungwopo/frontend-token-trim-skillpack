# Frontend Token Trim Skillpack — 日本語

[← README](../README.md) · [한국어](ko.md) · [English](en.md)

## 一言でいうと

**Ponytail + Graphify + Headroom** を組み合わせ、フロントエンド系エージェントが「読む量を減らし、変更量を減らし、検証をより正確にする」ための Hermes Agent スキルパックです。

## 何が良くなりますか？

フロントエンド作業でトークンが無駄になる原因は、多くの場合、最終コードではなく **不要な探索・長いログ・手戻り** です。このパックは作業順序を変えます。

| 問題 | 改善 |
|---|---|
| `app/` や `components/` 全体を早く読みすぎる | route/copy/component 検索で狭い経路を先に作る |
| 既存の helper/component/token を見落として新しく作る | 既存パターンを先に再利用する |
| 小さな UI 修正が大きなリファクタになる | 実際の flow を直す最小ファイルだけ触る |
| 検索結果・ログ・diff をそのまま貼る | ファイルマップと実行可能な証拠に圧縮する |
| QA 前にコンテキストが足りなくなる | browser/mobile QA と修正のための余白を残す |

## インストールされるスキル

### `ponytail`

- YAGNI
- 既存コード優先
- native HTML/CSS/platform feature 優先
- 新規依存を避ける
- shortest correct diff

防ぐもの: 過剰設計、重複 helper、不要な抽象化、大きすぎるリファクタ。

### `graphify`

実装前に小さなコード経路を作ります。

```txt
route/page → component → hook/API/state → style/token → QA target
```

例:

```txt
/app/(member)/program/page.tsx → ProgramViewer → useAssignedPrograms → program card CSS → /program at 390px
```

防ぐもの: 無関係なファイル読み、症状だけの修正、間違った層の修正。

### `headroom`

探索結果・ログ・報告を圧縮し、検証と修正に使うコンテキストを残します。

推奨される最終報告:

```txt
完了: <ユーザー視点の結果>
変更: <主要ファイル/挙動>
検証: <command/browser/viewport + result>
リスク: <なし、または残った制限>
```

### `frontend-token-trim`

3つのスキルをフロントエンド用ワークフローに統合します。

## 使う場面

- フロントエンドのバグ修正
- UI polish
- モバイル/レスポンシブ overflow 修正
- route/page/component 実装
- API連携のある frontend flow
- コンテキストコストを抑えたいコードレビュー

## QAを省略するためのものではありません

source-path inspection、アクセシビリティ、認証/権限/data integrity、lint/type/build/test、視覚作業の browser/mobile QA は必要です。

## モデル / エージェント対応

| 環境 | 対応 | 使い方 |
|---|---|---|
| Hermes Agent | Native | `./install.sh` 後、`frontend-token-trim` をロード |
| OpenAI Codex / Codex CLI | `AGENTS.md` 対応 | `templates/AGENTS.md` をプロジェクトルートの `AGENTS.md` としてコピー、または contract を貼る |
| Claude Code / Claude-style | `CLAUDE.md` 対応 | `templates/CLAUDE.md` をプロジェクトルートの `CLAUDE.md` としてコピー、または project rules に貼る |
| Google Gemini-style | Prompt-compatible | task または repo instructions に contract を貼る |
| OpenCode / terminal agents | Prompt-compatible | task prompt に contract と検証コマンドを書く |
| Tool なし chat model | Limited | チェックリストとして有用。ただし自動検証は限定的 |

## インストール

```bash
git clone https://github.com/kimyoungwopo/frontend-token-trim-skillpack.git
cd frontend-token-trim-skillpack
./install.sh
```

インストール後、新しい Hermes セッションを開始してください。

### Codex / Claude で使う場合

Codex と Claude Code は Hermes の skill installer を直接使うのではなく、repo rule file として適用します。

```bash
# Codex / OpenAI coding agents
cp templates/AGENTS.md /path/to/your-project/AGENTS.md

# Claude Code / Claude-style coding agents
cp templates/CLAUDE.md /path/to/your-project/CLAUDE.md
```

他のエージェントでは `templates/frontend-token-trim.md` を prompt に貼り付けてください。

## 使用例

```txt
frontend-token-trim を適用して、このフロントエンド issue を修正してください。
```

他のエージェント用 contract:

```txt
Apply Frontend Token Trim:
1) Graphify the narrow route/component/data/style path first.
2) Reuse existing components, hooks, API clients, styles, and tokens.
3) No new dependencies or broad refactors unless the current path proves they are necessary.
4) Touch the fewest files that fix the real flow.
5) Verify exact affected route plus 320/390 mobile overflow; include command/screenshot evidence.
6) Final report: changed files, verification result, remaining risk only.
```
