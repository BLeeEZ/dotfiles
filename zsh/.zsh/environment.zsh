# alias
alias em="emacsclient -c"

# alternate editor is required to start a new emacs daemon when calling emacsclient
export ALTERNATE_EDITOR=""
# preferred editor for local and remote sessions
export EDITOR="emacsclient -c"
export VISUAL="emacsclient -c"
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
eval `dircolors ~/.zsh/dircolors`
