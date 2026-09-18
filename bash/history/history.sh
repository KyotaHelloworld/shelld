#!/bin/bash
function history_setting() {
	export HISTFILE=${HOME}/.bash_history
	export HISTSIZE=10000
	export HISTFILESIZE=100000
	export HISTCONTROL=ignoredups:erasedups

	if [[ -f $HISTFILE ]]; then
		: # OK. file is exist
	else
		touch $HISTFILE
	fi

	shopt -s histappend
}
history_setting
unset -f history_setting
