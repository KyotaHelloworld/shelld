.PHONY: help apply-zsh apply-bash change-shell-to-zsh change-shell-to-bash
help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-20s\033[0m %s\n", $$1, $$2}'

apply-zsh: change-shell-to-zsh ## ログインシェルを zsh にして設定を適用
	bash ./install/install.sh zsh

apply-bash: change-shell-to-bash ## ログインシェルを bash にして設定を適用
	bash ./install/install.sh bash

change-shell-to-zsh: ## ログインシェルを zsh に変更
	bash ./install/change-shell.sh zsh

change-shell-to-bash: ## ログインシェルを bash に変更
	bash ./install/change-shell.sh bash
