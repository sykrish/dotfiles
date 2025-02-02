#!/bin/sh

. scripts/io.sh

DIR=$(pwd)

if [ -x "$(command -v apt)" ]; then
    export PACKAGE_MANAGER="apt"
    export INSTALL_FLAGS="install"
elif [ -x "$(command -v pacman)" ]; then
    export PACKAGE_MANAGER="pacman"
    export INSTALL_FLAGS="-S --noconfirm"
else
    error "Unsupported package manager"
    exit 1
fi

print() {
  printf "[${GREEN}info${NC}] - $1\n"
}

info "Validating package-manager in env-var: $PACKAGE_MANAGER"
print $PACKAGE_MANAGER
print $INSTALL_FLAGS

# Create a directory to store repositories
mkdir $HOME/repos

# Install additional programs from txt file
# while read -r program; do
#     sudo $PACKAGE_MANAGER $INSTALL_FLAGS "$program"
# done < pkglist

echo "$(cat -n $DIR/scripts/pkglist) "
sudo $PACKAGE_MANAGER $INSTALL_FLAGS $(cat $DIR/scripts/pkglist)

# Add user to video group for screen brightness control

# Clone slock repository
# git clone https://git.suckless.org/slock $HOME/repos/slock
# cd $HOME/repos/slock;
# make clean install;
# cd -;

# Clone and install ly display manager
# git clone --recurse-submodules https://github.com/fairyglade/ly repos/ly
# cd repos/ly
# make
# sudo make install installsystemd
# systemctl enable ly.service

# TODO: Install gammastep (instructions missing)

# TODO: Install display manager (instructions missing)
