#!/bin/bash

DF_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if ! git -C "$DF_DIR" submodule update --init --recursive; then
	echo "Failed to initialize Git submodules." >&2
	exit 1
fi

dotfiles=(
	bash_profile
	bashrc
	emacs.d
	gitconfig
	tmux.conf
	vim
)

for f in "${dotfiles[@]}"; do
	[[ -L $HOME/.$f ]] && {
		curr="$(readlink $HOME/.$f)"
			[[ $curr == $DF_DIR/$f ]] && { echo "$HOME/.$f already linked"; continue; }
			echo "Conflict: $HOME/.$f points to $current"
			continue
	}
	[[ -e "$HOME/.$f" ]] && { echo "Conflict: $HOME/.$f already exists"; continue; }
	ln -snv "$DF_DIR/$f" "$HOME/.$f"
done
