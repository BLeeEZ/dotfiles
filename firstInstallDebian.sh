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
ask_install "upgrade your system?"
if [[ $? -eq 1 ]]; then
  aptitude update
  aptitude upgrade
fi

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
  python-dev

# try zsh?
read -p "Do you want to use the zsh-shell? (y/n) " -n 1 yesOrNo
echo
if [[ $yesOrNo =~ ^[Yy]$ ]]; then
  sudo aptitude install zsh
  chsh -s $(which zsh)
fi

# clean downloaded and already installed packages
aptitude -v clean

# Install powerline fonts?
read -p "Install patched powerline fonts? (y/n) " -n 1 yesOrNo
echo
if [[ $yesOrNo =~ ^[Yy]$ ]]; then
    # fc-list will list all installed fonts
    source fonts/powerline-fonts/install.sh
fi

# Symlinking dotfiles via GNU stow
echo "Symlinking dotfiles via GNU stow"
for i in bash emacs zsh urxvt
do
 stow $i 
done
