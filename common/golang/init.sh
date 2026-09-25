#!/bin/bash
function golang_init() {
    if [ -n "$BASH_VERSION" ]; then
        local this_source="${BASH_SOURCE[0]}"
    else
        local this_source="${(%):-%x}"
    fi
    local this_dir
    this_dir=$(dirname "$this_source")
    if [[ -n $__SHELL_SETTING_GOLANG ]]; then
        return 0
    fi
    __SHELL_SETTING_GOLANG="loading"
    load_dir_files "$this_dir" "install-goenv.sh"
    __SHELL_SETTING_GOLANG="loaded"
}

golang_init
unset -f golang_init
