#!/usr/bin/env bash

# make sure only normal user run our script
if [ "$(id -u)" == "0" ]; then
  echo "This script must be run as normal user NOT as root"
  exit 1
fi

function ask_install() {
  read -p"$1 (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 1
  else
    return 0
  fi
}

ask_install "Install required packages?"
if [[ $? -eq 1 ]]; then
    sudo apt-get --quiet --assume-yes install git curl wget vim-nox stow tmux silversearcher-ag
fi

ask_install "Install zsh-shell?"
if [[ $? -eq 1 ]]; then
    echo "Install zsh"
    sudo apt-get --quiet --assume-yes install zsh
    echo "Change default shell to zsh"
    chsh -s $(which zsh)
    echo "stow zsh"
    stow zsh
fi

ask_install "Symlinking dotfiles via GNU stow?"
if [[ $? -eq 1 ]]; then
for i in bin tmux vim
do
    echo stow $i
    stow $i
done
fi
