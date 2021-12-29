#/bin/bash

ZSHRC="$HOME/.zshrc"

get_installer() {
if [ $SYSTEM == "Linux" ];
then 
  INSTALLER="sudo apt get";
else 
  # not_supported;
  INSTALLER="brew install";
fi;

}

print() {
  echo " - $1\n"
}

install_linux() {

  print "Installing following packages:"
  echo "$(cat -n pkglist) \n"
  sudo apt-get install $(cat pkglist)

  print "Installing zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  echo "...and its plugins!\n"
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

  echo "... enabling plugins."
  sed -i 's/plugin=(git)/plugin=(zsh-syntax-highlighting zsh-autosuggestions colored-man-pages git shrink-path fzf)/' $ZSHRC

  print "Creating links for dotfiles"
  ln -sv $PWD/.gitconfig $HOME
  ln -sv $PWD/templates/.gitmessage.txt $HOME
  ln -sv $PWD/.alias $HOME
  ln -sv $PWD/.env_vars $HOME

  # Append settings to .zsh file
  echo "# Appended by install script." >> $ZSHRC

  print "Env vars are managed by .zshrc file."
  echo "if [ -f $HOME/.env_vars ]; then source $HOME/.env_vars; fi" >> $ZSHRC

  print "Add  aliases to .zshrc file."
  echo "if [ -f $HOME/.alias ]; then source $HOME.alias; fi" >> $ZSHRC

}

not_supported() {
echo "Only Linux is supported at this moment."
exit 1
}

SYSTEM="$(uname)"
get_installer
echo $INSTALLER

if [ $SYSTEM == "Linux" ];
then 
  install_linux;
else 
  not_supported;
fi;

