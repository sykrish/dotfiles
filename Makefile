
all: install link

install:
	scripts/install_zsh.sh
	scripts/install.sh

link:
	$(info Creating links)
	$(info Deleting .zshrc since it will get a linked version)
	rm $$HOME/.zshrc
	stow --verbose --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */
