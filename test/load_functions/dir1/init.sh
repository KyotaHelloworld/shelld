function dir1_init() {
	if [ -n "$BASH_VERSION" ]; then
		local this_source="${BASH_SOURCE[0]}"
	else
		local this_source="${(%):-%x}"
	fi
	local this_dir
	this_dir=$(dirname "$this_source")

	echo "From dir1/init"
	source $this_dir/dir11/init.sh
}

dir1_init
