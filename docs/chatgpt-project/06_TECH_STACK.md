# 技術構成

バージョン固定の manifest / lockfile はない。端末に導入されたコマンドを使うため、この文書から実行時バージョンは判断できない。

| 要素 | 役割・依存条件 | 正本 |
| --- | --- | --- |
| Bash / Zsh | 設定の実行。導入スクリプトは Bash、起動設定は対象シェルで source | [install](../../install/install.sh)、[起動入口](../../init.sh) |
| make | 適用とシェル切替の入口。ビルド工程はない | [Makefile](../../Makefile) |
| getent / id / chsh | アカウント照会とログインシェル変更 | [change-shell.sh](../../install/change-shell.sh) |
| paru | 対象シェルが未導入の場合の導入手段 | [change-shell.sh](../../install/change-shell.sh) |
| mktemp / cmp / mv など | rc 生成・比較・退避 | [install.sh](../../install/install.sh) |
| ls / grep と LS_COLORS | 共通 alias と色設定。GNU 形式のオプションを使用 | [alias](../../common/aliases/ls.sh)、[色設定](../../common/ls_color/color.sh) |
| Git | ソース管理と Zsh の右プロンプト | [Git 表示](../../zsh/github_display/display.sh) |
| Docker / kubectl / goenv | 導入済みなら補完または環境初期化。shelld の通常起動では導入しない | [補完](../../zsh/completion/init.sh)、[Go 環境](../../common/golang/golang.sh) |
| systemctl / fcitx / Cursor | alias や環境設定の利用先。端末での導入は保証しない | [systemctl](../../common/aliases/systemctl.sh)、[fcitx](../../common/input_method/fcitx.sh)、[Cursor](../../zsh/alias/cursor/cursor.sh) |
| Beads (`bd`) | 開発課題と作業記録。シェル設定の利用には不要 | [生成 Beads skill](../../.agents/skills/beads/SKILL.md) |

[test/](../../test/) には読み込みと色表示のデモがある。統一された自動テスト runner、CI workflow、パッケージ配布工程はリポジトリにない。既存の検証方法は [開発ガイド](07_DEVELOPMENT_GUIDE.md) を参照。
