
install:
	scripts/install_zsh.sh
	scripts/install.sh

link:
	$(info installing asdf plugins)
	rm $$HOME/.zshrc
	stow --verbose --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */
