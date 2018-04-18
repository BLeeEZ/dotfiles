#! /bin/bash

params="-sf"

for i in .profile .bash_logout .bashrc;
do
  ln $params ./dotfiles/$i ../$i
done

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
