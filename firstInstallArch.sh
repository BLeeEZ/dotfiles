#!/usr/bin/env bash

# use the bash as default "sh", fixed some problems
# with e.g. third-party scripts
#sudo ln -sf /bin/bash /bin/sh

function ask_install() {
  echo
  echo
  read -p"$1 (y/n) " -n 1
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    return 1
  else
    return 0
  fi

}

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root"
  echo "Plese use sudo or su"
  exit 1
fi

# update && upgrade
ask_install "Upgrade your system?"
if [[ $? -eq 1 ]]; then
  pacman -Syu
fi

# Installing packages via aptitude?
read -p "Installing packages via pacman? (y/n) " -n 1 yesOrNo
echo
if [[ $yesOrNo =~ ^[Yy]$ ]]; then
  pacman -S \
    `# default for many other things` \
    tmux \
    autoconf \
    make \
    cmake \
    dialog \
    `# unzip, unrar etc.` \
    zip \
    unzip \
    tar \
    `# quickly find files on the filesystem based on their name` \
    mlocate \
    `# interactive processes viewer` \
    htop \
    `# interactive I/O viewer` \
    iotop \
    tree \
    `# disk usage viewer` \
    rsync \
    whois \
    vim \
    emacs \
    `# GNU bash` \
    bash \
    bash-completion \
    zsh \
    rxvt-unicode \
    `# get files from web` \
    wget \
    curl \
    `# repo-tools`\
    git \
    `# usefull tools` \
    stow \
    nodejs \
    npm \
    lynx \
    python \
    python-pip \
    python-setuptools \
    python-wheel
fi

# Install packages via pip?
read -p "Installing packages via pip? (y/n) " -n 1 yesOrNo
echo
if [[ $yesOrNo =~ ^[Yy]$ ]]; then
  pip3 install \
    `# bash correction` \
    thefuck
fi

# try zsh?
read -p "Do you want to use the zsh-shell? (y/n) " -n 1 yesOrNo
echo
if [[ $yesOrNo =~ ^[Yy]$ ]]; then
  pacman -S zsh
  chsh -s $(which zsh)
  stow zsh
fi

# Install powerline fonts?
read -p "Install patched powerline fonts? (y/n) " -n 1 yesOrNo
echo
if [[ $yesOrNo =~ ^[Yy]$ ]]; then
    # fc-list will list all installed fonts
    source fonts/powerline-fonts/install.sh
fi

# Symlinking dotfiles via GNU stow?
read -p "Symlinking dotfiles via GNU stow? (y/n) " -n 1 yesOrNo
echo
if [[ $yesOrNo =~ ^[Yy]$ ]]; then
    for i in bash emacs urxvt tmux qutebrowser
    do
        stow $i 
    done
fi