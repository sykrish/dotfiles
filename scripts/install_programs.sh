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
mkdir $HOME/repos 2>/dev/null

. scripts/manual_installs/check_hyprland.sh 2>/dev/null

pkglist=$(cat $DIR/scripts/pkglist | grep -vE '#')

if [ "$INSTALL_HYPRLAND" -eq 1 ]; then
    hyprland_pkglist=$(cat $DIR/scripts/pkglist_hyprland | grep -vE '#')
    pkglist="${pkglist}${hyprland_pkglist}"
fi

# TODO print with number echo "$(cat -n $DIR/scripts/pkglist) "
info "Packages to install"
echo "$pkglist"

sudo $PACKAGE_MANAGER $INSTALL_FLAGS $pkglist

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
