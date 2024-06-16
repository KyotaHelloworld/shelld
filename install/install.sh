function install_zshrc() {
	local this_dir=$(
		cd $(dirname ${BASH_SOURCE:-$0})
		pwd
	)
	cp $this_dir/default_rc/.zshrc ~/.zshrc

	# $(dirname ${this_dir}) returns root dir path
	echo "this_shelld_path=$(dirname ${this_dir})/init.sh" >>~/.zshrc
	echo "initial_load" >>~/.zshrc
	echo "unset -f initial_load" >>~/.zshrc
}
function install_bashrc() {
	local this_dir=$(
		cd $(dirname ${BASH_SOURCE:-$0})
		pwd
	)
	cp $this_dir/default_rc/.bashrc ~/.bashrc

	# $(dirname ${this_dir}) returns root dir path
	echo "this_shelld_path=$(dirname ${this_dir})/init.sh" >>~/.bashrc
	echo "initial_load" >>~/.bashrc
	echo "unset -f initial_load" >>~/.bashrc
}

function backup_zshrc() {
	local this_dir=$(
		cd $(dirname ${BASH_SOURCE:-$0})
		pwd
	)
	mkdir -p $this_dir/backup
	mv ~/.zshrc $this_dir/backup/$(backup_timestamp).zshrc
}
function backup_bashrc() {
	local this_dir=$(
		cd $(dirname ${BASH_SOURCE:-$0})
		pwd
	)
	mkdir -p $this_dir/backup
	mv ~/.bashrc $this_dir/backup/$(backup_timestamp).bashrc
}

function backup_timestamp() {
	date +'%y%m%d%H%M%S'
}

# install_shelld backup original rc file.
# arg
# 	1. give "zsh" or "bash" which you use
function install_shelld() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))
	local target_shell=$1
	if [ "$target_shell" != "zsh" ] && [ "$target_shell" != "bash" ]; then
		echo "Error: Target shell must be 'zsh' or 'bash'" >&2
		return -1
	fi

	if [ "$target_shell" = "zsh" ]; then
		backup_zshrc
		install_zshrc
	elif [ "$target_shell" = "bash" ]; then
		backup_bashrc
		install_bashrc
	fi
}

# install_shelld backup original rc file.
# arg
# 	1. give "zsh" or "bash" which you use
install_shelld $1
