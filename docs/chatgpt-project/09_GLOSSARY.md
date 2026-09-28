# 用語集

| 用語 | shelld での意味・正本 |
| --- | --- |
| apply | ログインシェル選択と対応 rc 設置の組合せ。[Makefile](../../Makefile) |
| change-shell | rc を設置せずログインシェルを選択する操作。[README](../../README.md) |
| rc | HOME の `.bashrc` / `.zshrc`。shelld では設定本体を読み込む生成入口。[ドメインモデル](03_DOMAIN_MODEL.md) |
| common | Bash / Zsh が共に読み込む設定群。[構成](04_ARCHITECTURE.md) |
| private | 最後に読み込む利用者所有の設定ディレクトリ。[ドメインモデル](03_DOMAIN_MODEL.md) |
| init.sh | 各設定階層の読み込み入口。単体のインストーラーではない。[ローダー](../../common/load_functions.sh) |
| rerun | Zsh で `.zshrc` を再度 source する alias。再ログインとは異なる。[定義](../../zsh/alias/rerun/rerun.sh) |
| Git 右プロンプト | Zsh が表示する branch または detached HEAD と作業状態。`github_display` という配置名だが GitHub への接続はしない。[定義](../../zsh/github_display/display.sh) |
| Beads | 課題と進行中の作業記録の正本。製品のシェル起動とは独立。[開発ガイド](07_DEVELOPMENT_GUIDE.md) |
