mklink /J "../.emacs.d" "../dotfiles/emacs/.emacs.d"
mklink /J "../.spacemacs.d" "../dotfiles/emacs/.spacemacs.d"

mklink /J "../.zsh" "../dotfiles/zsh/.zsh"
mklink "../.zshrc" "dotfiles/zsh/.zshrc"

mklink /J "C:\cygwin\home\%username%\.zsh" "C:\Users\%username%\dotfiles\zsh\.zsh"
mklink "C:\cygwin\home\%username%\.zshrc" "C:\Users\%username%\dotfiles\zsh\.zshrc"