#!/bin/bash

set -ex
SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

# Setup the initial files based on $SHELL

SHELL_TYPE=$(basename ${SHELL})
SHELLRC_FILE=~/.${SHELL_TYPE}rc

echo "export XDG_CONFIG_HOME=$SCRIPT_DIR" >> $SHELLRC_FILE
echo "export XDG_DATA_HOME=$SCRIPT_DIR" >> $SHELLRC_FILE
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

# add ssh config to .ssh/config
mkdir -p ~/.ssh
cat $SCRIPT_DIR/config >> ~/.ssh/config

# Add to git config

echo "[url \"ssh://git@github.com/\"]" >> ~/.gitconfig
echo "  insteadOf = https://github.com/" >> ~/.gitconfig

# Install coursier
curl -fLo coursier https://github.com/coursier/launchers/raw/master/coursier
chmod +x coursier
mv coursier $XDG_CONFIG_HOME/installs/coursier
coursier setup --install-dir $XDG_CONFIG_HOME/installs
