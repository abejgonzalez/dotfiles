# Powerline Statusbar
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/local/lib/python3.5/dist-packages/powerline/bindings/bash/powerline.sh

# Aliases
alias la="ls -al"
alias gitlog="git log --oneline --all --decorate --graph"

# Export variables
if [ -d /usr/local/cuda ]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda/lib64
fi
if [ -d /usr/local/cuda-8.0 ]; then
    export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/cuda-8.0/lib64
    export PATH=$PATH:/usr/local/cuda-8.0/bin
fi

export VISUAL=vim
export EDITOR="$VISUAL"
