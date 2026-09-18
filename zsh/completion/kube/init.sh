#!/bin/zsh
function completion_kube_init() {
	if command -v kubectl >/dev/null 2>&1; then
		source <(kubectl completion zsh)
	fi
}
completion_kube_init
unset -f completion_kube_init
