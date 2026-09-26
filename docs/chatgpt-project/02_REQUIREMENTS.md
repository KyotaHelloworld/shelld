# 要件

## 実装済みの契約

| 入力・前提 | 結果 | 根拠 |
| --- | --- | --- |
| `make apply-bash` / `make apply-zsh` | 対象ログインシェルを確認・変更してから対応 rc を設置 | [Makefile](../../Makefile)、[change-shell.sh](../../install/change-shell.sh) |
| 対象シェルが未導入 | paru があれば導入を試み、失敗時は停止 | [change-shell.sh](../../install/change-shell.sh) |
| 既存 rc が生成内容と異なる | HOME の一意な非公開バックアップディレクトリへ退避 | [install.sh](../../install/install.sh) |
| 同じ内容の再適用 | rc の新たなバックアップを作らない | [install.sh](../../install/install.sh) |
| Bash / Zsh による起動 | 共通設定、対象シェル設定、存在する個人設定を読む | [init.sh](../../init.sh) |
| Docker / kubectl がない | 対応する Zsh 補完の生成を省略 | [Docker 補完](../../zsh/completion/docker/init.sh)、[kubectl 補完](../../zsh/completion/kube/init.sh) |

インストールやシェル切替の失敗は非ゼロで終了し、rc の設置へ進まない。シェル変更後に rc 設置が失敗する場合は、ログインシェルまで自動では戻さない。復旧手順は [README](../../README.md) を参照。

## 検証の限界

[既存監査](../audits/20260925-01-shell-switch/report.md) はモックによるシェル切替、一時 HOME、Bash / Zsh 起動を検証した。実アカウントへの `chsh` やパッケージ導入を検証した記録ではない。

Mac 標準 Zsh と追加ツールを極力不要にする方針は [範囲](01_GOALS_AND_SCOPE.md) に定義する未実装の拡張。対応 OS バージョンと Mac 実行結果は未確定で、実装担当者が Beads 課題の着手時に確認する。全 OS 共通の互換性や性能目標を保証する資料はない。
