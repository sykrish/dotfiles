#!/usr/bin/env zsh

print() {
  printf "[${GREEN}info${NC}] - $1\n"
}

TARGET_DIR=$HOME/Downloads/emacs
mkdir -p $TARGET_DIR
cd $TARGET_DIR
wget https://ftp.gnu.org/gnu/emacs/emacs-29.4.tar.xz
tar -xf emacs-29.4.tar.xz

# Install required packages (packages based on debian / ubuntu)
sudo apt-get update
sudo apt-get -q=2 install build-essential libgtk-3-dev libgnutls28-dev libjpeg-dev \
    libpng-dev libgif-dev libtiff-dev libx11-dev libxpm-dev libxft-dev libxext-dev \
    libx11-xcb-dev libxcb1-dev libxrender-dev libxt-dev libxmu-dev libgpm-dev

# Configure and install emacs
./configure --with-x-toolkit=gtk3 --with-json --with-tree-sitter
make

print "Check if emacs work: ./src/emacs, if so, execute 'make install'"
