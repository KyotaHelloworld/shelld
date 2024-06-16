#!/bin/zsh
function download_kube_completion() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))

	local file_name="_kube"
	local file_url="https://kubernetes.io/docs/tasks/tools/install-kubectl-linux/#enable-shell-autocompletion"
	if [[ $(uname) == "Darwin" ]]; then
		file_url="https://kubernetes.io/docs/tasks/tools/install-kubectl-macos/#enable-shell-autocompletion"
	fi
	mkdir -p ${this_dir%/}/download

	if [[ ! -f "${this_dir%/}/download/${file_name#/}" ]]; then
		echo "\e[31mkube-completion downloading ...\e[0m"
		curl -o ${this_dir%/}/download/${file_name#/} ${file_url}

		if [[ -f ~/.zcompdump ]]; then
			rm ~/.zcompdump
		fi
	fi
}
