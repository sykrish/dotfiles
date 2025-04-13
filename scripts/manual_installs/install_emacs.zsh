#!/usr/bin/env zsh

print() {
  printf "[${GREEN}info${NC}] - $1\n"
}

debug_stop() {
  print "Press enter tko continue"
  read test
}

TARGET_DIR=$HOME/Downloads/emacs
mkdir -p $TARGET_DIR
cd $TARGET_DIR

wget https://ftp.gnu.org/gnu/emacs/emacs-29.4.tar.xz
tar -xf emacs-29.4.tar.xz

cd emacs-29.4

# Install required packages (packages based on debian / ubuntu)
sudo apt-get update
sudo apt-get -y -q=2 install build-essential libgtk-3-dev libgnutls28-dev libjpeg-dev \
    libpng-dev libgif-dev libtiff-dev libx11-dev libxpm-dev libxft-dev libxext-dev \
    libx11-xcb-dev libxcb1-dev libxrender-dev libxt-dev libxmu-dev libgpm-dev texinfo

# Configure and install emacs
./configure --with-x-toolkit=gtk3 --with-json --with-tree-sitter
make

print "Check if emacs work: ./src/emacs, if so, execute 'make install'"

debut_stop

# FIXME figure out why emacs does not start with the configs
print "Installing Doom emacs..."

git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
~/.config/emacs/bin/doom install
