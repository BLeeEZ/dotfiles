echo Install homebrew
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

echo Install stow
brew install stow
echo Install tmux
brew install tmux
echo Install the_silver_searcher
brew install the_silver_searcher

echo Preapre config files
for i in bash bin ranger tmux zsh vim
do
    echo stow $i
    stow $i
done

