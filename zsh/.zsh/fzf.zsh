# Set up fzf key bindings and fuzzy completion
source <(fzf --zsh)

alias ifind='fzf --preview="bat --color=always {}"'
alias ivim='vim $(fzf -m --preview="bat --color=always {}")'

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory
