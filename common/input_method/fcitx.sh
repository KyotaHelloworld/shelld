#!/bin/bash
function input_method_fcitx() {
    export XMODIFIERS=${XMODIFIERS:-"@im=fcitx"}
}

input_method_fcitx
unset -f input_method_fcitx
