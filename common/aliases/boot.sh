#!/bin/bash
function alias_boot(){
	alias reboot='sudo shutdown -r now'
	alias shutdown='sudo shutdown -h now'
}
alias_boot
unset -f alias_boot

