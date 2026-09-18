function dir4_init() {
	if [ -n "$BASH_VERSION" ]; then
		local this_source="${BASH_SOURCE[0]}"
	else
		local this_source="${(%):-%x}"
	fi
	local this_dir
	this_dir=$(dirname "$this_source")

	echo "From dir4/init"
	load_dir_files "$this_dir" "test3.sh"
}

dir4_init
