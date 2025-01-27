
all: install link

install:
	scripts/install_zsh.sh
	scripts/install.sh

link:
	$(info Deleting .zshrc since it will get a linked version)
	rm $$HOME/.zshrc

	$(info Creating links)
	stow --verbose --target=$$HOME --restow */
	stow --verbose --target=$$HOME/.config --restow .config

delete:
	$(info Deleting links)
	stow --verbose --target=$$HOME --delete */
	stow --verbose --target=$$HOME/.config --delete .config
