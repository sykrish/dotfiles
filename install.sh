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
  echo -e "\n - $1\n"
}

configure_nvim() {
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  	ln -sv $PWD/.vimrc $HOME/.nvimrc
	nvim --cmd PluginInstall --cmd qall
}

install_docker() {
	curl -fsSL https://get.docker.com -o get-docker.sh
 	sudo sh get-docker.sh
}

install_linux() {
  print "Please enter gitconfigs:"

  # Set git config correct
  read -p "Enter email that will be used mainly for git: " gitemail
  read -p "Enter name: " gitname

  print "Configure nvim? [y/n]"
  read nvim_consent

  print "Install docker?[y/n] info: https://docs.docker.com/engine/install/ubuntu/#install-using-the-convenience-script?"
  read docker_consent

  print "Install slack? [y/n]"
  read slack_consent

  print "Installing following packages:"
  echo "$(cat -n pkglist) "
  sudo apt-get install $(cat pkglist)

  if [[ $docker_consent == "Y" || $docker_consent == "y" ]]; then
	  print "Installing Docker."
	  install_docker
	  echo "OK."
  else
	  print "Skipping Docker."
  fi

  if [[ $slack_consent == "Y" || $slack_consent == "y" ]]; then
	  print "Installing Slack."
	  sudo apt-get install slack-desktop
	  echo "OK."
  else
	  print "Skipping Slack."
  fi

  print "Installing zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  echo "...and its plugins!"
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

  echo "... enabling plugins."
  sed -i 's/plugins=(git)/plugins=(zsh-syntax-highlighting zsh-autosuggestions mix colored-man-pages git shrink-path fzf asdf)/' $ZSHRC

  # Copy .gitconfig template so we can configure it.

  cp ./templates/.gitconfig $HOME

  sed -i "s/#GITEMAIL/$gitemail/" $HOME/.gitconfig
  sed -i "s/#GITNAME/$gitname/" $HOME/.gitconfig
  sed -i "s@#GITMESSAGE@$HOME/.gitmessage.txt@" $HOME/.gitconfig

  print "Creating links for dotfiles"
  ln -sv $PWD/templates/.gitmessage.txt $HOME
  ln -sv $PWD/.alias $HOME
  ln -sv $PWD/.env_vars $HOME

  # Append settings to .zsh file
  echo "# Appended by install script." >> $ZSHRC

  print "Env vars are managed by .zshrc file."
  echo "if [ -f $HOME/.env_vars ]; then source $HOME/.env_vars; fi" >> $ZSHRC

  print "Add  aliases to .zshrc file."
  echo "if [ -f $HOME/.alias ]; then source $HOME/.alias; fi" >> $ZSHRC

  if [[ $nvim_consent == "Y" || $nvim_consent == "y" ]]; then
	  print "Configuring nvim."
	  configure_nvim
	  echo "OK."
  else
	  echo "Skipping configuring nvim."
  fi

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

