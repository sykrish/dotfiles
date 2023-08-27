#!/bin/sh

# Create a directory to store repositories
mkdir $HOME/repos

# Install packages using the chosen package manager
sudo $PACKAGE_MANAGER $INSTALL_FLAGS 

# Install additional programs from the additional_programs.txt file
while read -r program; do
    sudo $PACKAGE_MANAGER $INSTALL_FLAGS "$program"
done < tool-programs.txt

# Add user to video group for screen brightness control
sudo usermod -a -G video $USER

# Clone slock repository
git clone https://git.suckless.org/slock $HOME/repos/slock
# Clone and install ly display manager
# git clone --recurse-submodules https://github.com/fairyglade/ly repos/ly
# cd repos/ly
# make
# sudo make install installsystemd
# systemctl enable ly.service

# TODO: Install gammastep (instructions missing)

# TODO: Install display manager (instructions missing)
