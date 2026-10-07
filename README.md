# shelld

Bash と Zsh のシェル設定。Linux では未インストールのシェルを paru で導入する。
macOS は標準 Zsh (`/bin/zsh`) のみを対象とし、追加のパッケージマネージャーは使用しない。

## 使い方

リポジトリのルートで、使いたいシェルを選ぶ。

```sh
make apply-zsh
# または
make apply-bash
```

どちらも現在のユーザーのログインシェルを切り替え、対応する `~/.zshrc` または `~/.bashrc` を設定する。`chsh` が認証を求める場合がある。変更を全ての端末へ反映するには、ログアウトして再ログインする。

既存の rc は `~/.shelld-backup.XXXXXXXX/` に移動し、保存先をコマンド出力に表示する。同じ設定の再適用ではバックアップを増やさない。以前の設定へ戻す場合は、表示された保存先の内容を確認してから該当 rc を HOME へ戻す。

ログインシェルだけを切り替える場合:

```sh
make change-shell-to-zsh
# または
make change-shell-to-bash
```

`install` は標準コマンドのまま使える。パッケージの導入には `paru -S <package>` を使う。以前の設定を読み込んだ端末に `install='paru -S'` が残っている場合は、新しいシェルを開くか `unalias install` で解除する。

プロジェクトの構成・開発方法は [プロジェクト概要](docs/chatgpt-project/00_PROJECT_OVERVIEW.md) を参照。進行中の課題と検証記録は Beads で管理する（開始時は `bd prime` と `bd ready --json`）。macOS の標準 Zsh 対応を含みますが、Mac 実機での確認は未完了です。

macOS では標準 Bash から実行できます。

```sh
bash install/change-shell.sh zsh && bash install/install.sh zsh
```

macOS は `dscl` でログインシェルを確認し、標準 `/bin/zsh` を使います。Linux 専用の paru、systemctl、fcitx、LS_COLORS と scan は読み込みません。`ls` は標準の `-G` で色表示します。

## 初回準備

```sh
git clone git@github.com:KyotaHelloworld/shelld.git
cd shelld
make help
```

`make apply-*` は `getent` と `chsh` を使用する。対象シェルがなければ paru でインストールする。必要な paru がない場合や、インストールまたは `chsh` が失敗した場合はそこで停止し、rc は変更しない。

リポジトリを移動すると生成済み rc の参照先は更新されない。移動先で `make apply-zsh` または `make apply-bash` を再実行する。

## 失敗時の復旧

| 状況 | 次の操作 |
| --- | --- |
| シェルの導入・切替が失敗 | 表示された paru / chsh のエラーを解消し、同じコマンドを再実行する。rc は未変更。 |
| ログインシェルの切替後、rc の設置が失敗 | 元の rc の自動復元を試みる。復元も失敗した場合は、エラーに表示された保存先に元の rc が残る。filesystem の問題を解消してから該当 rc を HOME へ戻し、導入を再実行する。ログインシェルは自動で元へ戻らない。 |
| 設定の読み込みでシェルが使えない | 下のコマンドで rc を読まないシェルを開き、設定を修正する。 |
| `goenv init failed` と表示される | 失敗した初期化の出力は適用されない。goenv を修復し、新しいシェルを開く。 |

```sh
bash --noprofile --norc
# または
zsh -f
```

## goenv の手動更新

通常のシェル起動は goenv installer を実行しない。既に `goenv` が `PATH` にあり、checkout が `~/.goenv` にある場合、repository root から手動で更新できる。

> [!IMPORTANT]
> 更新は network と `~/.goenv` の変更を伴う。自動実行や shell 設定の適用には含まれない。

```sh
bash common/golang/install-goenv.sh --help
bash common/golang/install-goenv.sh update
```

成功時は goenv の version と利用可能な Go version の案内を表示する。version 引数なしでは Go の install・global 切替・shell restart は行わない。

`git pull` が失敗したら、その status とエラーを返して後続の version 処理を止める。Go version は変更しないが、失敗した Git 操作は fetch 済みなどの途中状態を残し得る。Git の原因を解消してから同じ command を再実行する。`goenv` が見つからない場合も停止する。

既存の version 引数付き経路は `rerun` を呼ぶため、実環境での shell restart は未確認。今回の手順は version 引数なしの更新を対象とする。

version 引数付き経路では、Go の install 後に global 選択、shell reload、version 表示の順に進む。global 選択が失敗したら、そのエラーと status を返し、reload へ進まない。Go の install は取り消さないため、goenv の原因を解消して選択を再試行する。

`rerun` がない場合や reload が失敗した場合も非ゼロで停止する。この段階では global 選択済みなので、新しいシェルを開いて確認する。選択は自動では元に戻らない。

## プロンプト

Bash と Zsh は、ホスト・日時・現在地を上段、ユーザーと入力位置を下段に表示する。

```text
[baikin-castle 🏰] 09/23 16:38 ~/workspace/codex/universe
baikimman 👾 ❯
```

| ホスト | 表示 | ユーザー | 表示 |
| --- | --- | --- | --- |
| `baikin-castle` | 🏰 | `root` | 👑 |
| `baikin-ufo` | 🛸 | `baikimman` | 👾 |
| `dadandan` | 🤖 | `dokinchan` | 😈 |
| `bakery` | 🥐 | `kabilunlun` | 🦠 |

表にないユーザーは `🐛` を表示し、表にないホストには絵文字を付けない。既存の色分けも適用される。
