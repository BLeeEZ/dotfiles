# Make sure only root can run our script
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

echo Install stow
pacman -S --needed stow

ask_install "Install zsh-shell?"
if [[ $? -eq 1 ]]; then
  pacman -S --needed zsh
  echo Change default shell to zsh
  sudo -u $SUDO_USER chsh -s $(which zsh)
  stow zsh
fi

echo Stow config files
for i in bash profile bin ranger tmux vim
do
    echo stow $i
    stow $i
done
