# shelld

Bash と Zsh のシェル設定。Arch Linux 環境で、未インストールのシェルは paru で導入する。

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

## 初回準備

```sh
git clone git@github.com:KyotaHelloworld/shelld.git
cd shelld
make help
```

`make apply-*` は `getent` と `chsh` を使用する。対象シェルがなければ paru でインストールする。必要な paru がない場合や、インストールまたは `chsh` が失敗した場合はそこで停止し、rc は変更しない。`chsh` が成功した後に rc の設置だけ失敗した場合は、表示されたエラーを解消して同じコマンドを再実行する。元の rc はバックアップに残る。

リポジトリを移動すると生成済み rc の参照先は更新されない。移動先で `make apply-zsh` または `make apply-bash` を再実行する。
