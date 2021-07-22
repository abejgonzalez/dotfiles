#!/bin/bash

# Print stuff
set -x

# Setup the .bashrc file

BASHRC_FILE=~/.bashrc
echo "export CONFIG_DIR=$PWD" >> $BASHRC_FILE
echo "source \$CONFIG_DIR/.bash_common" >> $BASHRC_FILE
echo "source \$CONFIG_DIR/.bash_prompt" >> $BASHRC_FILE

# Install Vundle

git clone https://github.com/VundleVim/Vundle.vim.git $PWD/.vim/bundle/Vundle.vim

# Setup .vimrc properly

MODIFIED_PWD=$(echo $PWD | sed 's/\//\\\//g')
sed -i "s/\/scratch\/abejgonza\/config/$MODIFIED_PWD/g" $PWD/.vimrc
echo "Please run: vim -c 'VundleInstall' -c 'q' after relogging in"
