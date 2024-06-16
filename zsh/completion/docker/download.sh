#!/bin/zsh
function download_docker_completion() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))

	mkdir -p ${this_dir%/}/download

	# local file_name="_docker_compose"
	# local file_url="https://raw.githubusercontent.com/docker/compose/1.29.2/contrib/completion/zsh/_docker-compose"
	# if [[ ! -f "${this_dir%/}/download/${file_name#/}" ]]; then
	# 	echo "\e[31mdocker-completion downloading ...\e[0m"
	# 	curl -o ${this_dir%/}/download/${file_name#/} -L ${file_url}

	# 	if [[ -f ~/.zcompdump ]]; then
	# 		rm ~/.zcompdump
	# 	fi
	# fi

	local file_name="_docker"
	local file_url="https://raw.githubusercontent.com/docker/cli/master/contrib/completion/zsh/_docker"
	if [[ ! -f "${this_dir%/}/download/${file_name#/}" ]]; then
		echo "\e[31mdocker-completion downloading ...\e[0m"
		curl -o ${this_dir%/}/download/${file_name#/} -L ${file_url}

		if [[ -f ~/.zcompdump ]]; then
			rm ~/.zcompdump
		fi
	fi
}
