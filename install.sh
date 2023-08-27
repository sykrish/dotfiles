#/bin/bash

ZSHRC="$HOME/.zshrc"

print() {
  echo -e "\n - $1\n"
}

print "Set package-manager in env-var"
source ./init.sh

configure_nvim() {
	sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
		https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  	ln -sv $PWD/.vimrc $HOME/.nvimrc
	nvim --cmd PluginInstall --cmd qall
}

print "Configure nvim? [y/n]"
read nvim_consent
print "Creating links for dotfiles"
ln -sv $PWD/templates/.gitmessage.txt $HOME
ln -sv $PWD/.alias $HOME
ln -sv $PWD/.env_vars $HOME

# Append settings to .zsh file
echo "# Appended by install script." >> $ZSHRC

print "Env vars are managed by .zshrc file."
echo "if [ -f $HOME/.env_vars ]; then source $HOME/.env_vars; fi" >> $ZSHRC

print "Add aliases to .zshrc file."
echo "if [ -f $HOME/.alias ]; then source $HOME/.alias; fi" >> $ZSHRC

./install_programs.sh;

print "Installing zsh"
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "...and its plugins!"
git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

echo "... enabling plugins."
sed -i 's/plugins=(git)/plugins=(zsh-syntax-highlighting zsh-autosuggestions mix colored-man-pages git shrink-path fzf asdf)/' $ZSHRC

# Set ZSH as new default shell.
chsh -s /usr/bin/zsh
echo "Default shell: $SHELL"

print "Moving .config folder, this will overwrite existing"
cp -r .config/* $HOME/.config

if [[ $nvim_consent == "Y" || $nvim_consent == "y" ]]; then
  print "Configuring nvim."
  configure_nvim;
  echo "OK."
else
  echo "Skipping configuring nvim."
fi

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

print "Creating new group VIDEO & Add user to it for screen brightness control"
sudo usermod -a -G video $USER

print "Done"
