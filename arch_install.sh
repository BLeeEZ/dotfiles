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

function ask_install_package_selection() {
  ask_install "Install $1 packages?"
  if [[ $? -eq 1 ]]; then
    for x in $(cat ./archProgs.csv | grep -G ",$1," | awk -F, {'print $2","$1'})
      do
        installCmd=$(echo "$x,$SUDO_USER" | awk -F, {'
          if ($1 == "pacman")
            print "sudo pacman -S --needed "$2;
          else if ($1 == "yay")
            print "yay -S --needed "$2;
          else if ($1 == "code")
            print "code --install-extension "$2;
          else
            print "Error <"$1"> is not a valid command";
        '})
        echo $installCmd
        $installCmd
      done
  fi
}

ask_install "Upgrade your system?"
if [[ $? -eq 1 ]]; then
  sudo pacman -Syu
fi

ask_install_package_selection basic
ask_install_package_selection common

ask_install "Install zsh-shell?"
if [[ $? -eq 1 ]]; then
  sudo pacman -S --needed zsh
  echo Change default shell to zsh
  chsh -s $(which zsh)
  stow zsh
fi

ask_install "Install yay as AUR helper?"
if [[ $? -eq 1 ]]; then
  git clone https://aur.archlinux.org/yay.git
  if [ $? -eq 0 ]; then
    cd yay
    makepkg -si
    cd ..
    rm -R yay
  else
    echo "Abort yay installation: git clone failed"
  fi
fi

ask_install_package_selection AUR
ask_install_package_selection vs-code

ask_install "Symlinking dotfiles via GNU stow?"
if [[ $? -eq 1 ]]; then
  for i in bash profile bin ranger tmux vim vs-code
  do
    echo stow $i
    stow $i
  done
fi
