#!/bin/zsh
function completion_git_init() {
	# Git completion is provided by zsh's standard fpath and compinit.
	true
}
completion_git_init
unset -f completion_git_init
