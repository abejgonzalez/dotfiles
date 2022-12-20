#!/bin/bash

set -ex
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Setup the initial files based on $SHELL

SHELL_TYPE=$(basename ${SHELL})
SHELLRC_FILE=~/.${SHELL_TYPE}rc

echo "export XDG_CONFIG_HOME=$SCRIPT_DIR" >> $SHELLRC_FILE
echo "source \$XDG_CONFIG_HOME/.${SHELL_TYPE}_common" >> $SHELLRC_FILE
echo "source \$XDG_CONFIG_HOME/.${SHELL_TYPE}_prompt" >> $SHELLRC_FILE

# Install nightly version of neovim
mkdir installs
pushd installs
curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage
chmod u+x nvim.appimage
ln -sf nvim.appimage nvim
popd
echo "export PATH=\$XDG_CONFIG_HOME/installs:\$PATH" >> $SHELLRC_FILE

# Install Vundle

git clone https://github.com/VundleVim/Vundle.vim.git $SCRIPT_DIR/.vim/bundle/Vundle.vim

# Setup firrtl syntax for vim

git submodule update --init --recursive firrtl-syntax
pushd firrtl-syntax
mkdir -p $SCRIPT_DIR/.vim/syntax
mkdir -p $SCRIPT_DIR/.vim/ftdetect
ln -sf syntax/firrtl.vim $SCRIPT_DIR/.vim/syntax/firrtl.vim
ln -sf ftdetect/firrtl.vim $SCRIPT_DIR/.vim/ftdetect/firrtl.vim
popd

# add ssh config to .ssh/config
mkdir -p ~/.ssh
cat $SCRIPT_DIR/config >> ~/.ssh/config

# Add to git config

echo "[url \"ssh://git@github.com/\"]" >> ~/.gitconfig
echo "  insteadOf = https://github.com/" >> ~/.gitconfig
