#!/bin/zsh
function completion_git_init() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))
	load_dir_files "$this_dir"
	
	download_git_completion
	git_completion

	unset -f download_git_completion
	unset -f git_completion
}
completion_git_init
unset -f completion_git_init
