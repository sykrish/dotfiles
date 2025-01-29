#!/usr/bin/env sh

. scripts/io.sh

# Detect the package manager and set the environment variable
if [ -x "$(command -v apt)" ]; then
    info "package-manager: apt-get"
    export PACKAGE_MANAGER="apt-get"
    export INSTALL_FLAGS="-q=2 install"
elif [ -x "$(command -v pacman)" ]; then
    info "package-manager: pacman"
    export PACKAGE_MANAGER="pacman"
    export INSTALL_FLAGS="-S --noconfirm"
else
    error "Unsupported package manager"
    exit 1
fi

export DOTFILES=$(pwd)
info "Path of dotfiles set: $DOTFILES"

