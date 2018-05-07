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

# use aptitude in the next steps ...
if [ \! -f $(whereis aptitude | cut -f 2 -d ' ') ] ; then
  apt-get install aptitude
fi

# update && upgrade
ask_install "Upgrade your system?"
if [[ $? -eq 1 ]]; then
  aptitude update
  aptitude upgrade
fi

# Installing packages via aptitude?
read -p "Installing packages via aptitude? (y/n) " -n 1 yesOrNo
echo
if [[ $yesOrNo =~ ^[Yy]$ ]]; then
  aptitude install \
    `# default for many other things` \
    tmux \
    build-essential \
    autoconf \
    make \

    cmake \
    mktemp \
    dialog \
    `# unzip, unrar etc.` \
    zip \
    unzip \
    tar \
    `# quickly find files on the filesystem based on their name` \
    mlocate \
    locales \
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
    python-dev \
    python-setuptools \
    python-wheel \
    `# keyboard key remapping` \
    xcape
fi

# Installing i3-gaps?
read -p "Installing i3-gaps? (y/n) " -n 1 yesOrNo
echo
if [[ $yesOrNo =~ ^[Yy]$ ]]; then
  aptitude install \
    feh \
    compton \
    rofi \
    `# display brightness control` \
    xbacklight
  stow i3
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
  aptitude install zsh
  chsh -s $(which zsh)
  stow zsh
fi

# clean downloaded and already installed packages
read -p "Clean downloaded and already installed packages in aptitude? (y/n) " -n 1 yesOrNo
echo
if [[ $yesOrNo =~ ^[Yy]$ ]]; then
  aptitude -v clean
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
    for i in bash emacs urxvt tmux qutebrowser bin
    do
        stow $i
    done
fi
