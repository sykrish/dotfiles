#/bin/bash

ZSHRC="$HOME/.zshrc"

print() {
  echo -e "\n - $1\n"
}

print "Set package-manager in env-var"
source ./init.sh

configure_nvim() {
  print "Configure Nvim"
  sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  ln -sv $PWD/.vimrc $HOME/.nvimrc
  nvim --cmd PluginInstall --cmd qall
  print "Configure Nvim done"
}

# print "Creating links for dotfiles"
# ln -sv $PWD/templates/.gitmessage.txt $HOME
# ln -sv $PWD/.alias $HOME
# ln -sv $PWD/.env_vars $HOME

./install_programs.sh;

# print "Moving .config folder, this will overwrite existing"
# cp -r .config/* $HOME/.config

print "Configure nvim? [y/n]"
read nvim_consent
if [[ $nvim_consent == "Y" || $nvim_consent == "y" ]]; then
  print "Configuring nvim."
  configure_nvim;
  print "OK."
else
  print "Skipping configuring nvim."
fi


zsh() {
  print "Installing zsh"
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

  print "...and its plugins!"
  git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

  print "... enabling plugins."
  sed -i 's/plugins=(git)/plugins=(zsh-syntax-highlighting zsh-autosuggestions mix colored-man-pages git shrink-path fzf asdf)/' $ZSHRC

  # Set ZSH as new default shell.
  print "Setting ZSH as default shell..."
  chsh -s /usr/bin/zsh
  echo "Default shell: $SHELL"

  print "Append settings to .zsh file"
  echo "# Appended by install script." >> $ZSHRC

  print "Env vars are managed by .zshrc file."
  echo "if [ -f $HOME/.env_vars ]; then source $HOME/.env_vars; fi" >> $ZSHRC

  print "Add aliases to .zshrc file"
  echo "if [ -f $HOME/.alias ]; then source $HOME/.alias; fi" >> $ZSHRC
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

  print "Creating new group VIDEO & Add user to it for screen brightness control"
  sudo usermod -a -G video $USER

  print "Configure git: done"
}

emacs() {
  print "Installing Emacs..."
  # asdf plugin add emacs
  # or
  asdf plugin add emacs https://github.com/mimikun/asdf-emacs.git
  # Show all installable versions
  asdf list-all emacs

  # Install specific version
  asdf install emacs latest

  # Set a version globally (on your ~/.tool-versions file)
  asdf global emacs latest

  # Now emacs commands are available
  emacs --version
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

  # print "Doom emacs done"
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
