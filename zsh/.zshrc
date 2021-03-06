# load config
for config (~/.zsh/*.zsh) source $config

if [ "$(uname)" '==' "Darwin" ]; then
    # Do something under Mac OS X platform        
    for config (~/.zsh/mac/*.zsh) source $config
elif [ "$(expr substr $(uname -s) 1 5)" '==' "Linux" ]; then
    # Do something under GNU/Linux platform
    for config (~/.zsh/linux/*.zsh) source $config
elif [ "$(expr substr $(uname -s) 1 10)" '==' "MINGW32_NT" ]; then
    # Do something under 32 bits Windows NT platform
elif [ "$(expr substr $(uname -s) 1 10)" '==' "MINGW64_NT" ]; then
    # Do something under 64 bits Windows NT platform
fi

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

