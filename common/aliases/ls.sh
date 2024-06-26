#!/bin/bash
function alias_ls() {
    alias l='ls -CF'
    alias ll='ls -alF'
    alias la='ls -A'
    alias lh='ls -lh'
    alias llh='ls -alh'

    alias lsdir='ls -ld */'

    # enable color support of ls and also add handy aliases
    if [ -x /usr/bin/dircolors ]; then
        test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
        alias ls='ls --color=auto'
        #alias dir='dir --color=auto'
        #alias vdir='vdir --color=auto'
        alias grep='grep --color=auto'
        alias fgrep='fgrep --color=auto'
        alias egrep='egrep --color=auto'
    fi
}

alias_ls
unset -f alias_ls
