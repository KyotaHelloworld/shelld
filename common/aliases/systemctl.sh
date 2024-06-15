#!/bin/bash
function alias_systemctl(){
	alias restart='sudo systemctl restart'
	alias system='sudo systemctl'
}

alias_systemctl
unset -f alias_systemctl