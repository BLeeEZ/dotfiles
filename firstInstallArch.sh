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



ask_install "Upgrade your system?"
if [[ $? -eq 1 ]]; then
  pacman -Syu
fi

ask_install "Setting up network management?"
if [[ $? -eq 1 ]]; then
    pacman -S --needed \
           `# Networkmanager for wifi and DHCP` \
           networkmanager

    # Activating NetworkManager
    systemctl enable NetworkManager
    systemctl start NetworkManager
fi

ask_install_package_selection basic

ask_install "Install yaourt for AUR support (is required)?"
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

ask_install "Symlinking dotfiles via GNU stow?"
if [[ $? -eq 1 ]]; then
    for i in bash emacs tmux qutebrowser bin fonts ranger X11 i3 git-config
    do
        stow $i
    done
fi

ask_install "Specify the current machine type (needed for device dependent autostart)?"
if [[ $? -eq 1 ]]; then
    pacman -S --needed \
        `# Tool for user selection and dialog displaying for command line` \
        dialog
    selctionCmd=(dialog --no-cancel --title "Specify the current machine type?" --menu "Choose one of the following options:" 15 40 4)
    options=(1 "PC"
             2 "Laptop"
             3 "VM")
    choice=$("${selctionCmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    clear
    case $choice in
        1) hostType="pc" ;;
        2) hostType="laptop" ;;
        3) hostType="vm" ;;
    esac
    echo "echo $hostType" > ~/bin/hosttype
    chmod 755 ~/bin/hosttype
fi

ask_install_package_selection common
ask_install_package_selection i3

ask_install "Install st terminal?"
if [[ $? -eq 1 ]]; then
  sudo make clean install -C st
fi

ask_install "Install zsh-shell?"
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
