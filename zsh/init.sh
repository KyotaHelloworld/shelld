#!/bin/zsh
function zsh_init() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))
    load_dirs_init "$this_dir"
}
zsh_init
unset -f zsh_init

