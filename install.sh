#!/usr/bin/env bash

# Make sure only root can run the script
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root"
  echo "Plese use sudo or su"
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
            print $1" -S --needed "$2;
          else if ($1 == "yay")
            print "sudo -u "$3" "$1" -S --needed "$2;
          else if ($1 == "code")
            print "sudo -u "$3" "$1" --install-extension "$2;
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
  pacman -Syu
fi

ask_install_package_selection basic
ask_install_package_selection common

ask_install "Install zsh-shell?"
if [[ $? -eq 1 ]]; then
  pacman -S --needed zsh
  echo Change default shell to zsh
  sudo -u $SUDO_USER chsh -s $(which zsh)
  stow zsh
fi

ask_install "Install yay as AUR helper?"
if [[ $? -eq 1 ]]; then
  sudo -u $SUDO_USER git clone https://aur.archlinux.org/yay.git
  if [ $? -eq 0 ]; then
    cd yay
    sudo -u $SUDO_USER makepkg -si
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
