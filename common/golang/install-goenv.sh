#!/bin/bash
# This legacy helper can also be sourced; do not change the caller's shell options.
function help() {
    cat <<'EOF'
Purpose: Install or update the standalone goenv checkout, then optionally select Go.
Inputs: install or update; optional Go version uses the existing version-selection helper.
Changes: Network access and ~/.goenv; a supplied version can install Go and change goenv global.
Example: bash common/golang/install-goenv.sh update
Usage: install-goenv.sh {install|update} [Go-version]
Options: -h, --help shows this help without changing anything.
Prerequisites: Bash, git; update also needs goenv on PATH and ~/.goenv.
Exit behavior: Update failure stops before Go version changes and preserves git's nonzero status.
The legacy version-selection path also calls rerun; its real shell restart is not verified.
EOF
}

GOENV_SUB_COMMAND="${1:-}"
GOENV_TARGET_GO_VERSION="${2:-}"

function goenv_install() {
    if command -v goenv >/dev/null 2>&1; then
        echo Already installed.
        goenv --version
        return 0
    fi
    git clone https://github.com/go-nv/goenv.git ~/.goenv
}

function goenv_update() {
    if ! command -v goenv >/dev/null 2>&1; then
        echo "AT THE FIRST, INSTALL GOENV." >&2
        echo "run: goenv_install"
        return 2
    fi
    if git -C "$HOME/.goenv" pull; then
        echo "update successfully finished."
        goenv -v
        return 0
    else
        local result=$?
        printf 'goenv update failed; Go version was not changed. Resolve the git error and retry.\n' >&2
        return "$result"
    fi
}

function set_go_version() {
    GOENV_TARGET_GO_VERSION=$1
    if [[ -z $GOENV_TARGET_GO_VERSION ]]; then
        echo "available Go versions are"
        goenv install -l | tail -n 5
        echo "you can install Go like using next command."
        echo "    set_go_version 1.19.3"
        return 0
    fi

    goenv install $GOENV_TARGET_GO_VERSION
    if [[ $? -ne "0" ]]; then
        echo "go version" $GOENV_TARGET_GO_VERSION "is not exist."
        echo "you can choose go version in ..."
        goenv install -l | tail -n 5
        echo "or check with next command"
        echo "    goenv install -l"
        return 1
    fi

    goenv global $GOENV_TARGET_GO_VERSION 1>/dev/null 2>&1
    echo "restarting shell" && rerun
    go version
}

function main() {
    local result=0
    if [[ "${1:-}" == -h || "${1:-}" == --help ]]; then
        help
    elif [[ $GOENV_SUB_COMMAND = "install" ]]; then
        goenv_install && set_go_version "$GOENV_TARGET_GO_VERSION"
        result=$?
    elif [[ $GOENV_SUB_COMMAND = "update" ]]; then
        goenv_update && set_go_version "$GOENV_TARGET_GO_VERSION"
        result=$?
    fi
    # Cleanup must not turn a failed operation into a successful script exit.
    unset GOENV_SUB_COMMAND
    unset GOENV_TARGET_GO_VERSION
    return "$result"
}

main "$@"
