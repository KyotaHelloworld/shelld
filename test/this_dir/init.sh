function this_dir_init() {

	if [ -n "$BASH_VERSION" ]; then
		local this_source="${BASH_SOURCE[0]}"
	else
		local this_source="${(%):-%x}"
	fi
	local this_dir
	this_dir=$(dirname "$this_source")

	echo "from this_dir/init" $this_dir
	source $this_dir/../../common/load_functions.sh
	echo "from this_dir/init" $this_dir
	load_dirs_init "$this_dir"

	echo "test fin"
	echo $this_dir
	echo "${this_dir/#$HOME/\~}"
	WORKDIR=$HOME/workspace/butterflygate/shelld
	echo "${this_dir/#$WORKDIR/.}"
}
# /home/jam/workspace/butterflygate/shelld/test/this_dir

this_dir_init
