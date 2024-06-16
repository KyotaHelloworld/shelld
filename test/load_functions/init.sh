function load_functions_init() {

	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))

	source $this_dir/../../common/load_functions.sh
	load_dirs_init "$this_dir" "dir3"
}

load_functions_init
