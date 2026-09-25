#!/bin/zsh

rprompt-git-current-branch() {
	local branch_name changes line
	local has_untracked=false has_unstaged=false has_staged=false
	local branch_status

	branch_name=$(git symbolic-ref --quiet --short HEAD 2>/dev/null) ||
		branch_name=$(git rev-parse --short HEAD 2>/dev/null) || return 0
	changes=$(git status --porcelain=v1 --untracked-files=normal 2>/dev/null) || return 0

	while IFS= read -r line; do
		[[ -n $line ]] || continue
		if [[ ${line[1,2]} == '??' ]]; then
			has_untracked=true
		elif [[ ${line[2]} != ' ' ]]; then
			has_unstaged=true
		elif [[ ${line[1]} != ' ' ]]; then
			has_staged=true
		fi
	done <<< "$changes"

	if [[ $has_untracked == true ]]; then
		branch_status='%F{red}?'
	elif [[ $has_unstaged == true ]]; then
		branch_status='%F{red}+'
	elif [[ $has_staged == true ]]; then
		branch_status='%F{yellow}!'
	else
		branch_status='%F{green}'
	fi
	print -r -- "${branch_status}[${branch_name}]"
}

shelld_git_prompt_precmd() {
	RPROMPT=$(rprompt-git-current-branch)
}

autoload -Uz add-zsh-hook
add-zsh-hook precmd shelld_git_prompt_precmd
