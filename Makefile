MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))
CONFIG_DIR := $(MKFILE_DIR)

SHELLRC_FILE := ~/.bashrc

INSTALL_DIR := $(CONFIG_DIR)/installs/bin

.PHONY: default
default: bashrc_env neovim_install ssh_install gitconfig_install coursier_install

.PHONY: bashrc_env
bashrc_env:
	echo "export XDG_CONFIG_HOME=$(CONFIG_DIR)" >> $(SHELLRC_FILE)
	echo "export XDG_DATA_HOME=$(CONFIG_DIR)" >> $(SHELLRC_FILE)
	echo "source \$XDG_CONFIG_HOME/.bash_common" >> $(SHELLRC_FILE)
	echo "source \$XDG_CONFIG_HOME/.bash_prompt" >> $(SHELLRC_FILE)
	echo "export PATH=$(INSTALL_DIR):\$PATH" >> $(SHELLRC_FILE)

.PHONY: neovim_install
neovim_install:
	# Install nightly version of neovim
	mkdir -p $(INSTALL_DIR)
	cd $(INSTALL_DIR) \
		curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
		chmod u+x nvim.appimage \
		ln -sf nvim.appimage nvim

.PHONY: ssh_install
ssh_install:
	echo "Include $(CONFIG_DIR)/config" >> ~/.ssh/config

.PHONY: gitconfig_install
gitconfig_install:
	echo "[url \"ssh://git@github.com/\"]" >> ~/.gitconfig
	echo "  insteadOf = https://github.com/" >> ~/.gitconfig

.PHONY: coursier_install
coursier_install:
	curl -fLo coursier https://github.com/coursier/launchers/raw/master/coursier
	mv coursier $(INSTALL_DIR)/coursier
	chmod u+x coursier
	$(INSTALL_DIR)/coursier setup --install-dir $(INSTALL_DIR)
