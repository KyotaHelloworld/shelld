#!/bin/zsh
# kube_completion attaches completion function for kube command onto your shell
function kube_completion() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))
	local kube_completion_dir=${this_dir%/}/download}

	# Instructs the shell on how to provide inline, contextual hints
	zstyle ':completion:*:*:kube:*' script ${kube_completion_dir%/}/kube_completion.sh

	# The kube-completion.zsh is a function file, not designed to be sourced like the bash script.
	# This command appends the ./download directory onto the shell’s function lookup list.
	fpath=($kube_completion_dir $fpath)
}
