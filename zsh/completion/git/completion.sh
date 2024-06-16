#!/bin/zsh
# git_completion attaches completion function for git command onto your shell
function git_completion(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))
	local git_completion_dir=${this_dir%/}/download}
	
	# Instructs the shell on how to provide inline, contextual hints
	zstyle ':completion:*:*:git:*' script ${git_completion_dir%/}/git_completion.sh

	# The git-completion.zsh is a function file, not designed to be sourced like the bash script.
	# This command appends the ./download directory onto the shell’s function lookup list.
	fpath=($git_completion_dir $fpath)
}
