#!/usr/bin/env bash

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
          else
            print "sudo -u "$3" "$1" -S --needed "$2;
        '})
        echo $installCmd
        $installCmd
      done
  fi
}

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root"
  echo "Plese use sudo or su"
  exit 1
fi

# Setting the Home path to the user who calls this script with sudo
HOME=$(getent passwd $SUDO_USER | cut -d: -f6)
# Save dotfiles path
DOTFILES_PATH="$(cd "$(dirname "$0")" ; pwd -P )"

# update && upgrade
ask_install "Upgrade your system?"
if [[ $? -eq 1 ]]; then
  pacman -Syu
fi

# Setting up network management?
ask_install "Setting up network management?"
if [[ $? -eq 1 ]]; then
  pacman -S --needed \
    `# Networkmanager for wifi and DHCP` \
    networkmanager

  # Activating NetworkManager
  systemctl enable NetworkManager
  systemctl start NetworkManager
fi

ask_install "Installing yaourt for AUR support (is required)?"
if [[ $? -eq 1 ]]; then
  # Installing yaourt
  cd /tmp
  git clone https://aur.archlinux.org/package-query.git
  cd package-query/
  makepkg -si && cd /tmp/
  git clone https://aur.archlinux.org/yaourt.git
  cd yaourt/
  makepkg -si
  cd $DOTFILES_PATH
fi

ask_install_package_selection basic
ask_install_package_selection common
ask_install_package_selection i3

ask_install "Installing st terminal?"
if [[ $? -eq 1 ]]; then
  sudo make clean install -C st
fi

ask_install "Do you want to use the zsh-shell?"
if [[ $? -eq 1 ]]; then
  pacman -S --needed \
    zsh
  sudo -u $SUDO_USER chsh -s $(which zsh)
  stow zsh
fi

ask_install "Install patched powerline fonts?"
if [[ $? -eq 1 ]]; then
  # fc-list will list all installed fonts
  source externals/powerline-fonts/install.sh
fi

ask_install "Symlinking dotfiles via GNU stow?"
if [[ $? -eq 1 ]]; then
  for i in bash emacs tmux qutebrowser bin fonts ranger X11 i3
  do
    stow $i
  done
fi
