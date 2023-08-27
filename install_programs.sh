#!/bin/sh

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
