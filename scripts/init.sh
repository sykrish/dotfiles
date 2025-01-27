#!/usr/bin/env sh

# Detect the package manager and set the environment variable
if [ -x "$(command -v apt)" ]; then
    echo "package-manager: apt-get"
    export PACKAGE_MANAGER="apt-get"
    export INSTALL_FLAGS="-q=2 install"
elif [ -x "$(command -v pacman)" ]; then
    echo "package-manager: pacman"
    export PACKAGE_MANAGER="pacman"
    export INSTALL_FLAGS="-S --noconfirm"
else
    echo "Unsupported package manager"
    exit 1
fi
