#!/bin/bash
function common_init() {
    if [ -n "$BASH_VERSION" ]; then
        local this_source="${BASH_SOURCE[0]}"
    else
        local this_source="${(%):-%x}"
    fi
    local this_dir
    this_dir=$(dirname "$this_source")

    source "$this_dir/load_functions.sh"
    if [[ $(uname -s) == Darwin ]]; then
        load_dirs_init "$this_dir" input_method ls_color
    else
        load_dirs_init "$this_dir"
    fi
}

common_init
