#!/bin/bash
GOENV_SUB_COMMAND=$1
GOENV_TARGET_GO_VERSION=$2

function goenv_install () {
    which goenv 1>/dev/null 2>&1
    if [[ "$?" -eq "0" ]]; then
        echo Already installed.
        goenv --version
        return 0
    fi
    git clone https://github.com/syndbg/goenv.git ~/.goenv
}

function goenv_update () {
    which goenv 1>/dev/null 2>&1
    if [[ "$?" -ne "0" ]]; then
        echo "AT THE FIRST, INSTALL GOENV." >&2
        echo "you can use next command"
        echo "    goenv install 1.19.3"
        echo "    goenv global 1.19.3"
        return 2
    fi
    git -C ~/.goenv pull 1>/dev/null 2>&1
    if [[ $? -eq "0" ]]; then
        echo "update successfully finished."
        goenv -v
        return 0
    fi
}

function set_go_version () {
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


if [[ $GOENV_SUB_COMMAND = "install" ]]; then
    goenv_install \
    && set_go_version $GOENV_TARGET_GO_VERSION
fi

if [[ $GOENV_SUB_COMMAND = "update" ]]; then
    goenv_update \
    && set_go_version $GOENV_TARGET_GO_VERSION
fi


unset GOENV_SUB_COMMAND
unset GOENV_TARGET_GO_VERSION
