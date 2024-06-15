function install_zshrc(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))
	cp $this_dir/default_rc/.zshrc ~/.zshrc
}
function install_bashrc(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))
	cp $this_dir/default_rc/.bashrc ~/.bashrc
}

function backup_zshrc(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))
	mkdir -p $this_dir/backup
	mv ~/.zshrc $this_dir/backup
}
function backup_bashrc(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))
	mkdir -p $this_dir/backup
	mv ~/.bashrc $this_dir/backup
}


# install_shelld backup original rc file.
# arg
# 	1. give "zsh" or "bash" which you use
function install_shelld(){
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0}|awk '{print $NF}'))
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
