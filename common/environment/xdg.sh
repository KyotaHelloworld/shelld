#!/bin/bash
function environment_xdg() {
	local dirs="${XDG_DATA_DIRS:-}"
	case ":$dirs:" in
		*:/usr/local/share:*) ;;
		*) dirs="/usr/local/share${dirs:+:$dirs}" ;;
	esac
	case ":$dirs:" in
		*:/usr/share:*) ;;
		*) dirs="/usr/share${dirs:+:$dirs}" ;;
	esac
	export XDG_DATA_DIRS="$dirs"
}

environment_xdg
unset -f environment_xdg
