#!/bin/zsh
function completion_kube_init() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))
	load_dir_files "$this_dir"

	download_kube_completion
	kube_completion

	unset -f download_kube_completion
	unset -f kube_completion
}
completion_kube_init
unset -f completion_kube_init
