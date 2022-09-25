#!/bin/zsh

# script must be run from the dotfile directory

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# add dotfiles to this array
files=(".zshrc.shared" ".zsh" ".vimrc" ".emacs.d")

for i in "${files[@]}"
do
	# test that the symlink doesn't already exist
	if ! [[ -L ~/$i ]];
	then
	  # if there's no symlink, first check if any real files or directories are present and delete them if so
	  if [[ -f ~/$i || -d ~/$i ]];
	  then
	  	rm -rf ~/$i
	  fi
	  # create the symlink
	  ln -s $SCRIPT_DIR/$i ~/$i
	fi
done
