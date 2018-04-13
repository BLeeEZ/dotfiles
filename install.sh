#! /bin/bash

ln -s ./dotfiles/.profile ../.profile
ln -s ./dotfiles/.bash_logout ../.bash_logout
ln -s ./dotfiles/.bashrc ../.bashrc

if [ ! -L ../.emacs.d ]
then
  ln -s ./dotfiles/.emacs.d ../.emacs.d
else
  echo ".emacs.d already exists"
fi
 
if [ ! -L ../.spacemacs.d ]
then
  ln -s ./dotfiles/.spacemacs.d ../.spacemacs.d
else
  echo ".spacemacs.d already exists"
fi
