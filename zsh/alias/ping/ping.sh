#!/bin/zsh
function alias_ping() {
	alias pinga='(){ping 10.$1}'
	alias pingb='(){ping 172.0$1}'
	alias pingc='(){ping 192.168.$1}'
	alias scan='(){echo 192.168.$1.{1..254} | xargs -P256 -n1 ping -s1 -c1 -W1 | grep ttl}'
}

alias_ping
unset -f alias_ping
