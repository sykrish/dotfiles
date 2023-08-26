#!/usr/bin/env sh

# Detect the package manager and set the environment variable
if [ -x "$(command -v apt)" ]; then
    export PACKAGE_MANAGER="apt"
    export INSTALL_FLAGS="install"
elif [ -x "$(command -v pacman)" ]; then
    export PACKAGE_MANAGER="pacman"
    export INSTALL_FLAGS="-S --noconfirm"
else
    echo "Unsupported package manager"
    exit 1
fi
