# 設計原則

| 実装に表れている方針 | 理由・変更時の判断 | 根拠 |
| --- | --- | --- |
| 共通設定とシェル固有設定を分ける | 共通の変更は両シェルに影響するため、対応する入力経路を確認する | [init.sh](../../init.sh) |
| OS 変更と rc 設置を分け、順序を固定する | 切替失敗時に rc だけ変わることを避ける | [Makefile](../../Makefile) |
| 既存 rc を保持する | 利用者が以前の設定へ戻せるようにする | [install.sh](../../install/install.sh) |
| 同じ設定の再適用で不要な変更を増やさない | バックアップの増殖と PATH の重複を抑える。全設定の完全な冪等性までは保証しない | [rc 比較](../../install/install.sh)、[PATH](../../common/environment/path.sh) |
| 任意ツールは存在を確認して初期化する | Docker / kubectl / goenv がない場合にも該当初期化を省略できる | [Docker](../../zsh/completion/docker/init.sh)、[kubectl](../../zsh/completion/kube/init.sh)、[goenv](../../common/golang/golang.sh) |

OS に固有の alias やオプションには現在も依存がある。上の方針から Mac 対応済みとは推論しない。互換性を広げる場合の条件は [範囲](01_GOALS_AND_SCOPE.md) と Beads 課題を参照。
