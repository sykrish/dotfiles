

all:
	$(info installing asdf plugins)
	stow --verbose --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */
