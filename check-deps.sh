#!/bin/bash

HARDDEPS='make git vi vimx emacs tmux'

COMPILERS='gcc g++ python3 bash'

function checkdeps() {
	local err=0
	for arg; do
		if ! command -v $arg &> /dev/null; then
			echo "$arg"
			((err++))
		fi
	done
	return $err

}

echo "Checking HARDDEPS"
checkdeps $HARDDEPS && echo 'OK.'

echo
echo 'Checking Compilers/runtime'
checkdeps $COMPILERS && echo 'OK.'
