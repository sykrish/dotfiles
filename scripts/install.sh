#!/bin/zsh

ZSHRC="$HOME/.zshrc"
ASDF_DIR="$HOME/.asdf"

DIR=$(pwd)

. scripts/io.sh

info "Determine package-manager in env-var"
source $DIR/scripts/init.sh

configure_nvim() {
  #FIXME vimrc errors
  info "Installing neovim"

  latest_version=$(asdf list all neovim | grep -vE 'nightly|stable' | sort -V | tail -n 1)
  print "Latest version: $latest_version"

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
    warn "Skipping configuring neovim."
  fi

}

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

check_continue() {
  while true; do
    read -p "Do you wish to install this program? " yn
    case $yn in
    [Yy]*) break ;;
    [Nn]*) exit ;;
    *) echo "Please answer yes or no." ;;
    esac
  done
}

install_librewolf() {
  info "Installing librewolf"
  sudo apt update && sudo apt install extrepo -y
  sudo extrepo enable librewolf
  sudo apt update && sudo apt install librewolf -y
  print "Librewolf done, don't forget to change the settings!"
}

install_essentials() {
  info "Install essentials"
  sudo apt install curl -y
  print "done"
}

install_package_list() {
  info "install package list"
  $DIR/scripts/install_programs.sh;
  $DIR/scripts/manual_installs/install_eza.sh
  debug_stop
  print "done"
}

install_asdf_plugin() {
  info "Installing asdf plugin.."
  name=$1

  latest_version=$(asdf list all $name | grep -vE 'nightly|stable' | sort -V | tail -n 1)
  print "Latest version: $latest_version"

  asdf install $name $latest_version
  asdf global $name $latest_version
}

install_asdf() {
  info "Install asdf"

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.15.0

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

  info "Adding asdf plugins"
  # TODO add more plugins
  asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
  install_asdf_plugin elixir

  asdf plugin-add erlang https://github.com/asdf-vm/asdf-erlang.git

  warn "Skipped erlang installation"
  # FIXME erlang seems to cause problems installing it through script
  # asdf install erlang 27.2
  # asdf global $name $latest_version

  asdf plugin add neovim
  print "Adding asdf plugins done"
  debug_stop
}

configure_reshift() {
  # COFINGURE REDSHIFT?
  info "Creating new group VIDEO & Add user to it for screen brightness control"
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
  install_librewolf
  configure_nvim
  configure_reshift
}

install_all
