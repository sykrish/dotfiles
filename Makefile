

all:
	$(info installing asdf plugins)
	rm $$HOME/.zshrc
	stow --verbose --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */
