# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
#PS1="\e[0;32m[\@:\u@\h:\W]>>\e[m "
BYELLOW='\[\033[01;33m\]'
IBLACK='\[\033[0;90m\]'
GREY='\[\033[0;37m\]'
WHITE='\[\033[0;39m\]'
GREEN='\[\033[0;92m\]'
BLUE='\[\033[0;94m\]'
PS_CLEAR='\[\033[0m\]'
PS1="${BYELLOW}[\@]:${GREEN}[\u@\h]:${BLUE}[\W]${WHITE}\$ "
