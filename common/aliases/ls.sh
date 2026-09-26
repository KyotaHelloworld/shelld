#!/bin/bash
function alias_ls() {
    alias l='ls -CF'
    alias ll='ls -alF'
    alias la='ls -A'
    alias lh='ls -lh'
    alias llh='ls -alh'

    alias lsdir='ls -ld */'

    if [[ $(uname -s) == Darwin ]]; then
        alias ls='ls -G'
    else
        alias ls='ls --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi
}

alias_ls
unset -f alias_ls
