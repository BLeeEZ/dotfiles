# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# using vi key bindings for bash
set -o vi

# append to the history file, don't overwrite it
shopt -s histappend

# allows you to cd into directory merely by typing the directory name.
shopt -s autocd

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

if [[ ${EUID} == 0 ]] ; then
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W \$\[\033[00m\] '
else
  PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w \$\[\033[00m\] '
fi

# alias
alias ..="cd .."
alias ...="cd ../../"
alias ....="cd ../../../"
alias .....="cd ../../../../"
alias md='mkdir -p'
alias rd=rmdir

# List directory contents
alias lsa='ls -lah --color=yes'
alias l='ls -lah --color=yes'
alias ll='ls -lh --color=yes'
alias la='ls -lAh --color=yes'

alias xreload="xrdb ~/.Xresources"
alias gdot="cd ~/dotfiles/"
alias gdoc="cd ~/Documents/"
alias gpic="cd ~/Pictures/"
alias gdl="cd ~/Downloads/"

# Emacs
export EMACS_LAUNCHER='emacsclient --alternate-editor ""'
alias emacs="$EMACS_LAUNCHER --no-wait"
alias e="$EMACS_LAUNCHER"
alias te="$EMACS_LAUNCHER -nw"

# path adjustments
export PATH=$PATH:$HOME/bin
export EDITOR="emacsclient -nw --alternate-editor '' -c"
export TERMINAL="st"
export BROWSER="qutebrowser"

# language
export LC_COLLATE=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_MESSAGES=en_US.UTF-8
export LC_MONETARY=en_US.UTF-8
export LC_NUMERIC=en_US.UTF-8
export LC_TIME=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export LESSCHARSET=utf-8

# The time the shell waits, in hundredths of seconds, for another key
# to be pressed when reading bound multi-character sequences.
#
# This allows escape sequences like cursor/arrow keys to work,
# while eliminating the delay exiting vi insert mode.
KEYTIMEOUT=50

# changing dircolors
#eval `dircolors ~/.dircolors`
eval "$(dircolors ~/.dircolors)"

# git aliase
alias g='git'

alias ga='git add'
alias gaa='git add --all'

alias gb='git branch'
alias gba='git branch -a'

alias gc='git commit -v'
alias gc!='git commit -v --amend'
alias gca='git commit -v -a'
alias gca!='git commit -v -a --amend'
alias gclean='git clean -fd'
alias gpristine='git reset --hard && git clean -dfx'
alias gco='git checkout'
alias gcob='git checkout -b'
alias gcom='git checkout master'

alias gd='git diff'

alias gf='git fetch'
alias gfo='git fetch origin'

alias glg='git log --stat'
alias glog='git log --oneline --decorate --graph'

alias gm='git merge'
alias gmom='git merge origin/master'
alias gmt='git mergetool --no-prompt'

alias gp='git push'

alias grh='git reset HEAD'
alias grhh='git reset HEAD --hard'

alias gst='git status'
alias gsu='git submodule update'
