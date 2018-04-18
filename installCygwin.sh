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

# use apt-cyg in the next steps ...
if [ \! -f $(whereis apt-cyg | cut -f 2 -d ' ') ] ; then
    lynx -source rawgit.com/transcode-open/apt-cyg/master/apt-cyg > apt-cyg
    install apt-cyg /bin
    rm apt-cyg
fi

# update && upgrade
ask_install "upgrade your system?"
if [[ $? -eq 1 ]]; then
    apt-cyg update
fi

apt-cyg install \
        `# get files from web` \
        wget \
        curl \
        `# default for many other things` \
        tmux

# zsh
ask_install "Do you want to use the zsh-shell?"
if [[ $? -eq 1 ]]; then
  apt-cyg install zsh
  echo "right click on the Sygwin icon in windows and add '/bin/zsh --login'"
  echo ""
  echo "e.g.: C:\cygwin64\bin\mintty.exe -i /Cygwin-Terminal.ico /bin/zsh --login -"
fi
