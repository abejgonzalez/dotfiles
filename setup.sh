#!/bin/bash

set -x
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Setup the initial files based on $SHELL

SHELL_TYPE=$(basename ${SHELL})
SHELLRC_FILE=~/.${SHELL_TYPE}rc

echo "export CONFIG_DIR=$SCRIPT_DIR" >> $SHELLRC_FILE
echo "source \$CONFIG_DIR/.${SHELL_TYPE}_common" >> $SHELLRC_FILE
echo "source \$CONFIG_DIR/.${SHELL_TYPE}_prompt" >> $SHELLRC_FILE

# Install Vundle

git clone https://github.com/VundleVim/Vundle.vim.git $SCRIPT_DIR/.vim/bundle/Vundle.vim

# Add to git config

echo "[url \"ssh://git@github.com/\"]" >> ~/.gitconfig
echo "  insteadOf = https://github.com/" >> ~/.gitconfig

# Setup .vimrc properly

MODIFIED_PWD=$(echo $SCRIPT_DIR | sed 's/\//\\\//g')
sed -i "s/\/scratch\/abejgonza\/config/$MODIFIED_PWD/g" $SCRIPT_DIR/.vimrc
echo "Please run: vim -c 'VundleInstall' -c 'q' after relogging in"

# Setup firrtl syntax for vim

git submodule update --init --recursive firrtl-syntax
pushd firrtl-syntax
mkdir -p $SCRIPT_DIR/.vim/syntax
mkdir -p $SCRIPT_DIR/.vim/ftdetect
ln syntax/firrtl.vim $SCRIPT_DIR/.vim/syntax/firrtl.vim
ln ftdetect/firrtl.vim $SCRIPT_DIR/.vim/ftdetect/firrtl.vim
popd

# add ssh config to .ssh/config
mkdir -p ~/.ssh
cat $SCRIPT_DIR/config >> ~/.ssh/config
