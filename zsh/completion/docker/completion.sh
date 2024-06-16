#!/bin/zsh
function docker_completion() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))
	local docker_completion_dir=${this_dir%/}/download}

	# Instructs the shell on how to provide inline, contextual hints
	zstyle ':completion:*:*:docker:*' script ${docker_completion_dir%/}/docker_completion.sh

	# The docker-completion.zsh is a function file, not designed to be sourced like the bash script.
	# This command appends the ./download directory onto the shell’s function lookup list.
	fpath=($docker_completion_dir $fpath)
}
