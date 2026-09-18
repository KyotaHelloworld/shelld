.PHONY: help apply-zsh apply-bash change-shell-to-zsh
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

REPODIR:=$(dir $(abspath $(lastword $(MAKEFILE_LIST))))
apply-zsh: change-shell-to-zsh ## zsh をデフォルトシェルに設定し、このディレクトリの設定を適用させる
	./install/install.sh zsh

apply-bash: ## .bashrc file を変更し、このディレクトリの設定を適用させる
	./install/install.sh bash

change-shell-to-zsh: ## shell を zsh に変更する
	bash ./install/change_to_zsh.sh
