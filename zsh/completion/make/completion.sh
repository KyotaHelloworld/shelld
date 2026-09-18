#!/bin/zsh
_make_phony_words() {
  local opt_revert

  if [ -n "${BASH_VERSION:-}" ]; then
    shopt -q nullglob || {
      opt_revert=1 ; shopt -s nullglob ;
    }

  elif [ -n "${ZSH_VERSION:-}" ]; then
    [[ -o nullglob ]] || {
      opt_revert=1 ; setopt nullglob
    }
  fi

  for f in ./?akefile ./*.make ; do
    sed -nEe '/^.PHONY/ { s/^.PHONY:[ ]?// ; p ; } ' "$f" | tr ' ' $'\n' | sort -u
  done

  if [ -n "$opt_revert" ]; then

    [ -n "${ZSH_VERSION:-}" ] && unsetopt nullglob
    [ -n "${BASH_VERSION:-}" ] && shopt -u nullglob
  fi
  unset opt_revert
}

_make_phony_complete() {
	local -a targets
	targets=("${(@f)$(_make_phony_words)}")
	_describe 'make target' targets
}

compdef _make_phony_complete make
