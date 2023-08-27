#!/bin/sh

if [ -x "$(command -v apt)" ]; then
    echo "package-manager: apt"
    export PACKAGE_MANAGER="apt"
    export INSTALL_FLAGS="install"
elif [ -x "$(command -v pacman)" ]; then
    echo "package-manager: pacman"
    export PACKAGE_MANAGER="pacman"
    export INSTALL_FLAGS="-S --noconfirm"
else
    echo "Unsupported package manager"
    exit 1
fi

print "Validating package-manager in env-var: $PACKAGE_MANAGER"
echo $PACKAGE_MANAGER
echo $INSTALL_FLAGS

# Create a directory to store repositories
mkdir $HOME/repos

# Install additional programs from txt file
# while read -r program; do
#     sudo $PACKAGE_MANAGER $INSTALL_FLAGS "$program"
# done < pkglist

sudo $PACKAGE_MANAGER $INSTALL_FLAGS $(cat pkglist)

# Add user to video group for screen brightness control

# Clone slock repository
git clone https://git.suckless.org/slock $HOME/repos/slock
cd $HOME/repos/slock; 
make clean install;
cd -;
# Clone and install ly display manager
# git clone --recurse-submodules https://github.com/fairyglade/ly repos/ly
# cd repos/ly
# make
# sudo make install installsystemd
# systemctl enable ly.service

# TODO: Install gammastep (instructions missing)

# TODO: Install display manager (instructions missing)
