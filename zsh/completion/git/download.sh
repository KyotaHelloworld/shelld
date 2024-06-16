#!/bin/zsh
function download_git_completion() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))

	local file_name="git_completion.sh"
	local file_url="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh"
	mkdir -p ${this_dir%/}/download
	if [[ ! -f "${this_dir%/}/download/${file_name#/}" ]]; then
		echo "\e[31mgit-completion downloading ...\e[0m"
		curl -o ${this_dir%/}/download/${file_name#/} ${file_url}

		if [[ -f ~/.zcompdump ]]; then
			rm ~/.zcompdump
		fi
	fi

	file_name="_git"
	file_url="https://raw.githubusercontent.com/git/git/master/contrib/completion/git-completion.zsh"
	if [[ ! -f "${this_dir%/}/download/${file_name#/}" ]]; then
		echo "\e[31mgit-completion downloading ...\e[0m"
		curl -o ${this_dir%/}/download/${file_name#/} ${file_url}

		if [[ -f ~/.zcompdump ]]; then
			rm ~/.zcompdump
		fi
	fi
}
