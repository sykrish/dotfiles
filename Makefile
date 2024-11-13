TARGET = $(HOME)
PROGRAMS = foo bar

.PHONY: all install something bar foo

all: $(PROGRAMS)

install: essentials zsh asdf

essentials:
	$(info installing essentials...)
	apt install git curl

zsh:
	$(info installing zsh...)
	apt install zsh
	chsh -s /usr/bin/zsh
	$(info installing on my zsh & plugins...)
	sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
	git clone https://github.com/zsh-users/zsh-autosuggestions $HOME/.oh-my-zsh/custom/plugins/zsh-autosuggestions
	git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $HOME/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
	$(info configuring zsh...)

asdf:
	$(info installing asdf plugins)
	#git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.14.1
	$(info installing elixir and erlang)
	asdf plugin-add elixir https://github.com/asdf-vm/asdf-elixir.git
	asdf plugin add erlang https://github.com/asdf-vm/asdf-erlang.git

foo:
	echo "foo for you"

bar:
	echo "something different $(PROGRAMS)"
