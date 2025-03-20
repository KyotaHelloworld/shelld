#!/bin/bash
function environment_xdg() {
	export XDG_DATA_DIRS=/usr/share:/usr/local/share:$XDG_DATA_DIRS
}

environment_xdg
unset -f environment_xdg
