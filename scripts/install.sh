#!/bin/zsh

ZSHRC="$HOME/.zshrc"
GREEN='\033[0;32m'
NC='\033[0m' # No color
ASDF_DIR="$HOME/.asdf"

DIR=$(pwd)

print() {
  printf "[${GREEN}info${NC}] - $1\n"
}

debug_stop() {
  print "Press enter to continue"
  read test
}

print "Determine package-manager in env-var"
source $DIR/scripts/init.sh

configure_nvim() {
  print "Installing neovim"

  latest_version=$(asdf list all neovim | grep -vE 'nightly|stable' | sort -V | tail -n 1)
  echo "Latest version: $latest_version"

  asdf install neovim $latest_version
  asdf global neovim $latest_version

  print "Configure neovim? [y/n]"
  read neovim_consent
  if [[ $neovim_consent == "Y" || $neovim_consent == "y" ]]; then
    print "Configuring neovim."
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
    ln -sv $PWD/.vimrc $HOME/.nvimrc
    neovim --cmd PluginInstall --cmd qall
    print "Configure Nvim done"
    print "OK."
  else
    print "Skipping configuring neovim."
  fi

}

# print "Creating links for dotfiles"
# ln -sv $PWD/templates/.gitmessage.txt $HOME
# ln -sv $PWD/.alias $HOME
# ln -sv $PWD/.env_vars $HOME

# print "Moving .config folder, this will overwrite existing"
# cp -r .config/* $HOME/.config


configure_git() {
  print "Please enter gitconfigs:"
  # Set git config correct
  read -p "Enter email that will be used mainly for git: " gitemail
  read -p "Enter name: " gitname

  #Ensure .gitconfig exists
  touch $HOME/.gitconfig
  sed -i "s/#GITEMAIL/$gitemail/" $HOME/.gitconfig
  sed -i "s/#GITNAME/$gitname/" $HOME/.gitconfig
  sed -i "s@#GITMESSAGE@$HOME/.gitmessage.txt@" $HOME/.gitconfig
  # Copy .gitconfig template so we can configure it.
  cp ./templates/.gitconfig $HOME

  print "Configure git: done"
}

install_emacs() {
  print "Installing Emacs..."
  print "SKIIPED FOR NOW"
  # asdf plugin add emacs
  # or
  # asdf plugin-add emacs https://github.com/mimikun/asdf-emacs.git
  # Show all installable versions
  # asdf list-all emacs
  # debug_stop

  # Install specific version
  # asdf install emacs latest
  # asdf install emacs 29.4

  # Set a version globally (on your ~/.tool-versions file)
  # asdf global emacs latest

  # Now emacs commands are available
  # emacs --version
  # cd ~/Downloads/
  # wget https://ftp.gnu.org/gnu/emacs/emacs-29.4.tar.xz
  # tar -xf emacs-29.4.tar.xz
  # cd emacs-29.4

  # ./configure
  # check_continue()

  # make
  # print "Validate if emacs is installed correctly: ./src/emacs"

  # print "Installing Doom emacs..."

  # git clone --depth 1 https://github.com/doomemacs/doomemacs ~/.config/emacs
  # ~/.config/emacs/bin/doom install

  print "Doom emacs done"
}

check_continue() {
  while true; do
    read -p "Do you wish to install this program? " yn
    case $yn in
        [Yy]* ) break;;
        [Nn]* ) exit;;
        * ) echo "Please answer yes or no.";;
    esac
  done
}

librewolf() {
  print "Installing librewolf"
  sudo apt update && sudo apt install extrepo -y
  sudo extrepo enable librewolf
  sudo apt update && sudo apt install librewolf -y
  print "Librewolf done, don't forget to change the settings!"
}

install_essentials() {
  print "Install essentials"
  sudo apt install curl -y
}

install_package_list() {
  print "install package list"
  $DIR/scripts/install_programs.sh;
  $DIR/scripts/manual_installs/install_eza.sh
  debug_stop
}

install_asdf_plugin() {
  print "Installing asdf plugin.."
  name=$1


  latest_version=$(asdf list all $name | grep -vE 'nightly|stable' | sort -V | tail -n 1)
  print "Latest version: $latest_version"

  asdf install $name $latest_version
  asdf global $name $latest_version
}

install_asdf() {
  print "Install asdf"
  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.15.0
  # TODO check if echo goes correctly
  echo '. "$HOME/.asdf/asdf.sh"' >> $ZSHRC
  print "Source $ZSHRC so that asdf works"
 if [[ "$SHELL" == *zsh ]]; then
    source $ZSHRC
 else
   . $ZSHRC
 fi
  source $ZSHRC
  print "Install asdf done"
  debug_stop

  # echo "# append completions to fpath" >> $ZSHRC
  # echo "fpath=(${ASDF_DIR}/completions $fpath)" >> $ZSHRC
  # echo "# initialise completions with ZSH's compinit" >> $ZSHRC
  # echo "autoload -Uz compinit && compinit" >> $ZSHRC
  # source $ZSHRC
  # debug_stop

  print "Adding asdf plugins"
  # TODO add more plugins
  # Perhaps handle plugins for the software themselves?
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  install_asdf_plugin elixir
  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git
  asdf install erlang 27.2
  asdf global $name $latest_version

  asdf plugin add neovim
  print "Adding asdf plugins done"
  debug_stop
}

configure() {
  # COFINGURE REDSHIFT?
  print "Creating new group VIDEO & Add user to it for screen brightness control"
  sudo usermod -a -G video $USER
}

update_zsh_dotfiles() {
  echo "export DOTFILES=$DOTFILES" >> $DOTFILES/home/.zshrc
  echo "source $DOTFILES/.alias" >> $DOTFILES/home/.zshrc
}

install_all() {
  sudo apt-get update
  install_essentials
  if [ -n "$ZSH_VERSION" ]; then
    print "ZSH alreadt installed"
  elif [ -n "$BASH_VERSION" ]; then
    ./install_zsh.sh
  fi
  update_zsh_dotfiles
  install_asdf
  install_package_list
  install_emacs
  configure_nvim
}

install_all
