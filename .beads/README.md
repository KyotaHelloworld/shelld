# Beads Work Records

shelld の active task、要件整理、検証・引継ぎは Beads の課題と comment を正本とする。

repository または登録済み worktree で次を実行する。

```sh
bd prime
bd ready --json
```

対象課題の確認・claim・検証後の close は、公式生成の [Beads skill](../.agents/skills/beads/SKILL.md) と `bd prime` に従う。
[開発ガイド](../docs/chatgpt-project/07_DEVELOPMENT_GUIDE.md) に repository の作業境界を記載する。

- `bd where` で実際の workspace を確認する。linked worktree は primary の同じ DB を参照する。
- DB 本体と runtime file は Git 管理しない。Git の source commit だけでは課題のバックアップにならない。
- `metadata.json`、`config.yaml`、Git hook は Beads の生成物。手動で DB を移動・複製しない。
- remote URL の設定は同期実行の許可を意味しない。Dolt remote 同期は別途ユーザーの許可を得る。
- `.agents/chats/` と `.agents/tasks/` は導入前の履歴として保持し、新規の進捗を書き込まない。
