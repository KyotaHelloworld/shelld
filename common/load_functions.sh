#!/bin/bash

# load_dir_files loads all files which are existing in specified directory
# You can specify exclude files won't be loaded at 2nd or subsequent argument.
# This function expects called from init.sh, so init.sh is included in the exclude files.
# !CAUTION
#   * DO NOT include own file calling this function.
#   * BE CAREFULL not to call this function recursively.
# ex.) load_dir_files "$this_dir" "file1.sh" "file2.sh"
# args
#   1. give the dir name which call this function
#   2. give file names which you won't be loading
#   [option] specifing +init.sh at 2nd option allows loading init.sh
# return errors
#   1. when the 1st arg is specified unexisting dir
#   2. when the files specified at 2nd or subsequent args don't exist in the 1st arg dir
function load_dir_files() {
    local dir=$1
    shift # shift changes args order. now $1 returns prev $2, $2 returns prev $3 ...
    local init_sh=false

    # the 2nd arg is now positioned at 1st due to shift called before
    if [ "$1" = "+init.sh" ]; then
        init_sh=true
        shift
    fi
    if [ "$init_sh" = true ]; then
        echo "[CAUTION!] $dir/init.sh will be loaded"
        source "$dir/init.sh"
    fi

    # init.sh and $@ (exclude files you specified in args) won't be loaded.
    local exclude_files=("init.sh" "$@")

    if [ ! -d "$dir" ]; then
        echo "Error: Directory '$dir' does not exist." >&2
        return 1
    fi
    for file in "$dir"/*.sh; do
        if [[ ! " ${exclude_files[@]} " =~ " ${file##*/} " ]]; then
            source "$file"
        fi
    done
}

# load_dirs_init loads all init.sh files existing at 1 depth under of the specified directory.
# !CAUTION
#   * BE CAREFULL not to call this function recursively.
# args
#   1. give the dir name which call this function
#   2. give dir names which you won't be loading
# return errors
#   1. when the 1st arg is specified unexisting dir
#   2. when the dirs specified at 2nd or subsequent args don't exist in the 1st arg dir
# usage
# load_dirs_init "$this_dir" "dir3"
# ./
# ├── dir1
# │   ├── dir11
# │   │   └── init.sh  // x due to 2 depth from called file
# │   └── init.sh      // o
# ├── dir2
# │   └── init.sh      // o
# ├── dir3
# │   └── init.sh      // x due to dir3 is specified at 2nd arg
# ├── dir4
# │   └── test.sh      // x due to init.sh not exist
# └── init.sh          // call this function
function load_dirs_init() {
    local dir=$1
    shift
    local exclude_dirs=("$@")

    if [ ! -d "$dir" ]; then
        echo "Error: Directory '$dir' does not exist." >&2
        return 1
    fi

    for subdir in "$dir"/*; do
        if [ -d "$subdir" ]; then
            local init_sh_file="$subdir/init.sh"
            if [ -f "$init_sh_file" ]; then
                if [[ ! " ${exclude_dirs[@]} " =~ " ${subdir##*/} " ]]; then
                    source "$init_sh_file"
                fi
            fi
        fi
    done
}

function unset_load_functions() {
    unset -f load_dir_files
    unset -f load_dirs_init
}
