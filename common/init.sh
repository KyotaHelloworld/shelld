#!/bin/bash
function common_init(){
    local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))

    source $this_dir/load_functions.sh
    load_dirs_init "$this_dir"
}

common_init
