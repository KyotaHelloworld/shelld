#!/bin/bash
function input_method_fcitx(){
    local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))

    if [[ -z $GTK_IM_MODULE ]] || [[ -z $XMODIFIERS ]] || [[ -z $QT_IM_MODULE ]] ; then
        echo "[SUGGESTION] put environment for fcitx in /etc/environment"
        echo "[SUGGESTION] check exporting env value in $this_dir"
    fi

    export GTK_IM_MODULE=${GTK_IM_MODULE:-"fcitx"}
    export XMODIFIERS=${XMODIFIERS:-"@im=fcitx"}
    export QT_IM_MODULE=${QT_IM_MODULE:-"fcitx"}
}

input_method_fcitx
unset -f input_method_fcitx