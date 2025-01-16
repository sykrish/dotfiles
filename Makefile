

all:
	$(info installing asdf plugins)
	stow --verbose --adopt --target=$$HOME --restow */

delete:
	stow --verbose --target=$$HOME --delete */
