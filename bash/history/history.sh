#!/bin/bash
function history_setting () {
	export HISTFILE=${HOME}/.bash_history
	export HISTSIZE=1000
	export SAVEHIST=100000

	if [[ -f $HISTFILE ]]; then
		: # OK. file is exist
	else
		touch $HISTFILE
	fi

	setopt hist_ignore_dups
	setopt EXTENDED_HISTORY
}
history_setting
unset -f history_setting