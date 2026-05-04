#!/usr/bin/env bash

function fatal()
{
    echo "[err]" "$@" >&2
    exit 1
}

# This is dodgy, but works for my purpose
function get-package-list-dir()
{
    if which pacman &>/dev/null; then
        echo 'archlinux'
        return
    fi

    # This is not supported in install step yet
    if which apt-get &>/dev/null; then
        echo 'ubuntu'
        return
    fi

    return 1
}

function install-package-list-file()
{
    LIST_FILE=$1
    if which pacman &>/dev/null; then
        cat $LIST_FILE | xargs pacman --sync --noconfirm --quiet
        return
    fi

    return 1
}

BASE_PACKAGE_LIST_DIR="package.list.d/"
PACKAGE_LIST_DIR=$(get-package-list-dir || fatal "Couldn't determine package list dir: unknown package manager.")

readarray PACKAGE_LIST < <(ls "$BASE_PACKAGE_LIST_DIR$PACKAGE_LIST_DIR")
echo "Available package lists:"
echo ${PACKAGE_LIST[@]}
printf "Install? (y/N): "
read INSTALL
if [ "$INSTALL" = "y" ]; then
    for PACKAGE_LIST_FILE in ${PACKAGE_LIST[@]}; do
        echo "Installing $PACKAGE_LIST_FILE"
        PACKAGE_LIST_PATH="$BASE_PACKAGE_LIST_DIR/$PACKAGE_LIST_DIR/$PACKAGE_LIST_FILE"
        install-package-list-file $PACKAGE_LIST_PATH || fatal "Couldn't install things."
    done 

    echo "All done!"
fi


echo "Ok, bye..."


