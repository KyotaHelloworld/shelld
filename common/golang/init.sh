#!/bin/bash
function golang_init() {
    local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))
    if [[ -n $__SHELL_SETTING_GOLANG ]]; then
        echo "Attempting to read golang setting again"
        return 0
    fi
    export __SHELL_SETTING_GOLANG="failed"
    load_dir_files "$this_dir"
    export __SHELL_SETTING_GOLANG="succeed"
}

golang_init
unset -f golang_init
