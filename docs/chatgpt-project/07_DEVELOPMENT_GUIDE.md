# 開発ガイド

## 準備と作業の正本

設定の導入は [README](../../README.md)、必要なツールは [技術構成](06_TECH_STACK.md) を参照。Mac の動作確認済み手順はまだない。

開発では [AGENTS.md](../../AGENTS.md) に従い、専用 branch / worktree を使用する。リポジトリのルートで次を実行し、現在の手順と着手可能な課題を確認する。

```sh
bd prime
bd ready --json
```

対象課題を読んで claim し、検証結果と完了理由も同じ課題へ記録する。発見した別課題は元課題へ関連付ける。コマンドの詳細は [生成 Beads skill](../../.agents/skills/beads/SKILL.md) が正本。`.agents/chats/` と `.agents/tasks/` は過去の記録として保持し、新しい進捗を追記しない。課題の claim / close は merge、push、端末変更、Dolt remote sync の許可にはならない。

## 変更と検証

共通設定は `common/`、シェル固有設定は `bash/` / `zsh/`、導入処理は `install/` に置く。生成 rc は編集先にしない。個人設定や秘密情報は Git に追加せず、[ignore 規則](../../.gitignore) の対象を確認する。

文書だけの変更では相対リンクと差分を確認する。導入スクリプトを変えた場合の、端末を変更しない確認例:

```sh
make help
bash -n install/install.sh
bash -n install/change-shell.sh
bash install/install.sh --help
bash install/change-shell.sh --help
git diff --check
```

導入・復旧と goenv 初期化の回帰確認は Python 3、Bash、Zsh がある環境で実行する。実 HOME、アカウント、package manager は操作せず、一時 HOME とコマンドの mock を使う。

```sh
PYTHONDONTWRITEBYTECODE=1 python3 -m unittest discover -s test -p test_shell_recovery.py -v
```

実行挙動を変更した時は [既存監査](../audits/20260925-01-shell-switch/report.md) の方法を参考に、変更経路へ絞って確認する。シェル切替はコマンドをモックし、rc・起動・履歴は一時 HOME に隔離する。デモ群を一括実行して回帰テストの代わりにしない。

> [!CAUTION]
> `make apply-*` と `make change-shell-to-*` は実アカウントに作用する。構文確認や文書検証のためには実行しない。

## 失敗時の入口

- シェル導入・切替エラー、rc 復元、リポジトリ移動後の再適用: [README](../../README.md)。
- 設定読み込みの問題: [構成と実行順](04_ARCHITECTURE.md) に沿って共通・対象シェル・個人設定を切り分ける。
- Beads の解決先・手順の問題: `bd prime` と [生成 skill](../../.agents/skills/beads/SKILL.md) を確認し、既存 DB を再初期化しない。

Beads の生成統合ファイルは公式 CLI が所有する。DB や生成 hook を長期理解資料にコピーしない。
