#!/bin/zsh

# script must be run from the dotfile directory

# add dotfiles to this array
files=(".zshrc" ".zsh" ".vimrc" )

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
	  ln -s $i ~/$i
	fi
done