#!/bin/zsh

# git ブランチ名を色付きで表示させるメソッド
function rprompt-git-current-branch {
  local branch_name st branch_status

  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    # git 管理されていないディレクトリは何も返さない
    return
  fi

  branch_name=$(git rev-parse --abbrev-ref HEAD 2>/dev/null)
  st=$(git status 2>/dev/null)
  if [[ -n $(echo "$st" | grep "^nothing to") ]]; then
    # 全て commit されてクリーンな状態
    branch_status="%F{green}"
  elif [[ -n $(echo "$st" | grep "^Untracked files") ]]; then
    # git 管理されていないファイルがある状態
    branch_status="%F{red}?"
  elif [[ -n $(echo "$st" | grep "^Changes not staged for commit") ]]; then
    # git add されていないファイルがある状態
    branch_status="%F{red}+"
  elif [[ -n $(echo "$st" | grep "^Changes to be committed") ]]; then
    # git commit されていないファイルがある状態
    branch_status="%F{yellow}!"
  elif [[ -n $(echo "$st" | grep "^rebase in progress") ]]; then
    # コンフリクトが起こった状態
    echo "%F{red}!(no branch)"
    return
  else
    # 上記以外の状態の場合
    branch_status="%F{blue}"
  fi
  # ブランチ名を色付きで表示する
  echo "${branch_status}[$branch_name]"
}

function github_display() {
  # プロンプトが表示されるたびにプロンプト文字列を評価、置換する
  setopt prompt_subst

  # プロンプトの右側にメソッドの結果を表示させる
  RPROMPT='`rprompt-git-current-branch`'
}

github_display
unset -f github_display
