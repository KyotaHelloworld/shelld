# shelld

Bash と Zsh のシェル設定。Linux では未インストールのシェルを paru で導入する。
macOS は標準 Zsh (`/bin/zsh`) のみを対象とし、追加のパッケージマネージャーは使用しない。

## 使い方

リポジトリのルートで、使いたいシェルを選ぶ。

Linux:

```sh
make apply-zsh
# または
make apply-bash
```

macOS は `make` がなくても標準の Bash から直接実行できる。

```sh
bash install/change-shell.sh zsh && bash install/install.sh zsh
```

どちらの環境でも現在のユーザーのログインシェルを切り替え、対応する rc を設定する。`chsh` が認証を求める場合がある。変更を全ての端末へ反映するには、ログアウトして再ログインする。macOS では `make apply-zsh` も同じ処理を実行する。

既存の rc は `~/.shelld-backup.XXXXXXXX/` に移動し、保存先をコマンド出力に表示する。同じ設定の再適用ではバックアップを増やさない。以前の設定へ戻す場合は、表示された保存先の内容を確認してから該当 rc を HOME へ戻す。

ログインシェルだけを切り替える場合:

```sh
make change-shell-to-zsh
# または
make change-shell-to-bash
```

## 初回準備

Linux では次のように取得し、利用できるコマンドを確認する。

```sh
git clone git@github.com:KyotaHelloworld/shelld.git
cd shelld
make help
```

macOS では取得済みのリポジトリへ移動し、上の Bash による直接実行手順を使える。`make` は不要。

シェル変更処理は現在のログインシェルを確認してから `chsh` を実行する。Linux では `getent` で確認し、対象シェルがなければ paru で導入する。macOS では `dscl` で確認し、`/bin/zsh` の存在を確認する。確認、導入、`chsh` のいずれかが失敗した場合は rc を変更しない。`chsh` が成功した後に rc の設置だけ失敗した場合は、表示されたエラーを解消して `bash install/install.sh zsh` を再実行する。元の rc はバックアップに残る。

macOS では Linux 専用の paru、systemctl、fcitx、LS_COLORS の設定と `scan` エイリアスを読み込まない。`ls` は標準の `-G` で色表示する。macOS 実機での起動とシェル切り替えは未検証。

リポジトリを移動すると生成済み rc の参照先は更新されない。移動先で利用環境に対応する上記の適用コマンドを再実行する。
