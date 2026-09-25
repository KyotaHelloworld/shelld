#!/bin/zsh
function history_setting() {
	export HISTFILE=${HOME}/.zsh_history
	export HISTSIZE=10000
	export SAVEHIST=100000

	[[ -f $HISTFILE ]] || touch "$HISTFILE"

	setopt hist_ignore_dups
	setopt EXTENDED_HISTORY
}
history_setting
unset -f history_setting
