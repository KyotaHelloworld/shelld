#!/bin/zsh
function completion_docker_init() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))
	load_dir_files "$this_dir"

	download_docker_completion
	docker_completion

	unset -f download_docker_completion
	unset -f docker_completion
}
completion_docker_init
unset -f completion_docker_init
