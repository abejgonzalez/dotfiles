# .bash_profile

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi

# User specific environment and startup programs

# Path specific changes
PATH=$PATH:$HOME/.local/bin:$HOME/bin
export PATH

# Quick way to get home
FIRESIM=$HOME/firesim

# Better ls
alias l="ls -alh --color=auto"


