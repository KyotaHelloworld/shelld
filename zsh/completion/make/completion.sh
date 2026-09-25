#!/bin/zsh
_make_phony_words() {
  setopt local_options null_glob

  for f in ./?akefile ./*.make ; do
    sed -nEe '/^.PHONY/ { s/^.PHONY:[ ]?// ; p ; } ' "$f" | tr ' ' $'\n' | sort -u
  done

}

_make_phony_complete() {
	local -a targets
	targets=("${(@f)$(_make_phony_words)}")
	_describe 'make target' targets
}

compdef _make_phony_complete make
