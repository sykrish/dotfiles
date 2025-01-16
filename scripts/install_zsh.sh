#!/usr/bin/env bash

zsh() {
  print "Installing zsh"
  sudo apt install zsh -y

  print "Installing oh my zash"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
  # debug_stop
  # # Set ZSH as new default shell.
  # print "Setting ZSH as default shell..."
  # chsh -s /usr/bin/zsh

  print "Setting zsh as default"
  chsh -s $(which zsh) $USER
  exec zsh
  echo "Default shell: $SHELL"
  debug_stop

  print "Zsh installed, enable zsh and continue the script"
  # exit 0
  configure_zsh
}

configure_zsh() {
  print "...and its plugins!"
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

  git clone https://github.com/asdf-vm/asdf.git ~/.asdf
  debug_stop

  print "... enabling plugins."
  sed -i 's/plugins=(git)/plugins=(zsh-syntax-highlighting zsh-autosuggestions mix colored-man-pages git shrink-path fzf asdf)/' $ZSHRC
  debug_stop

  print "Append settings to .zsh file"
  echo "# Appended by install script." >> $ZSHRC

  print "Env vars are managed by .zshrc file."
  echo "if [ -f $HOME/.env_vars ]; then source $HOME/.env_vars; fi" >> $ZSHRC

  print "Add aliases to .zshrc file"
  echo "if [ -f $HOME/.alias ]; then source $HOME/.alias; fi" >> $ZSHRC
  debug_stop
}
