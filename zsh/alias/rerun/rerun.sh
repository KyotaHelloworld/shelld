#!/bin/zsh
function alias_rerun () {
	alias rerun='source ~/.zshrc'
}

alias_rerun
unset -f alias_rerun