echo Install homebrew
#/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo Install stow
brew install stow
echo Install tmux
brew install tmux
echo Install the_silver_searcher
brew install the_silver_searcher
# Command-line fuzzy finder written in Go
echo Install fzf
brew install fzf
# Clone of cat(1) with syntax highlighting and Git integration
echo Install bat
brew install bat

echo Preapre config files
for i in bash bin ranger tmux zsh vim
do
    echo stow $i
    stow $i
done

