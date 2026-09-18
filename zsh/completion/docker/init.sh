#!/bin/zsh
function completion_docker_init() {
	if command -v docker >/dev/null 2>&1; then
		source <(docker completion zsh)
	fi
}
completion_docker_init
unset -f completion_docker_init
