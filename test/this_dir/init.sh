function this_dir_init() {

	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))

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
