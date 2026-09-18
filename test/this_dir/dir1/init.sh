function dir1_init() {

	if [ -n "$BASH_VERSION" ]; then
		local this_source="${BASH_SOURCE[0]}"
	else
		local this_source="${(%):-%x}"
	fi
	local this_dir
	this_dir=$(dirname "$this_source")
	echo "from dir1/init this_dir UPDATED:" "${this_dir/#$HOME/\~}"
	load_dirs_init "$this_dir"
	load_dir_files "$this_dir"
}

dir1_init
