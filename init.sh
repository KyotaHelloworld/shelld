function shelld_init() {
	if [ -z "$ZSH_VERSION" ] && [ -z "$BASH_VERSION" ]; then
		echo "Error: This script must be run in zsh or bash" >&2
		return 1
	fi

	if [ -n "$BASH_VERSION" ]; then
		local this_source="${BASH_SOURCE[0]}"
	else
		local this_source="${(%):-%x}"
	fi
	local this_dir
	this_dir=$(dirname "$this_source")
	source "$this_dir/common/init.sh"
	if [ -n "$ZSH_VERSION" ]; then
		source "$this_dir/zsh/init.sh"
	elif [ -n "$BASH_VERSION" ]; then
		source "$this_dir/bash/init.sh"
	fi
	
	if [ -e "$this_dir/private" ]; then
		load_dir_files "$this_dir/private"
	fi
	unset_load_functions
}

shelld_init
unset -f shelld_init
