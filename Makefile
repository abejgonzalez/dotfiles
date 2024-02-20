MKFILE_PATH := $(abspath $(lastword $(MAKEFILE_LIST)))
MKFILE_DIR := $(dir $(MKFILE_PATH))
CONFIG_DIR := $(MKFILE_DIR)

SHELLRC_FILE := ~/.bashrc

INSTALL_DIR := $(CONFIG_DIR)/installs/bin

.PHONY: default
default: bashrc_env neovim_install ssh_install gitconfig_install coursier_install nodejs_install lastpass_install ripgrep_install

.PHONY: bashrc_env
bashrc_env:
	echo "export XDG_CONFIG_HOME=$(CONFIG_DIR)" >> $(SHELLRC_FILE)
	echo "export XDG_DATA_HOME=$(CONFIG_DIR)" >> $(SHELLRC_FILE)
	echo "source $$XDG_CONFIG_HOME/.bash_common" >> $(SHELLRC_FILE)
	echo "source $$XDG_CONFIG_HOME/.bash_prompt" >> $(SHELLRC_FILE)
	echo "export PATH=$(INSTALL_DIR):$$PATH" >> $(SHELLRC_FILE)

.PHONY: neovim_install
neovim_install:
	# Install nightly version of neovim
	mkdir -p $(INSTALL_DIR)
	cd $(INSTALL_DIR) \
		&& curl -LO https://github.com/neovim/neovim/releases/latest/download/nvim.appimage \
		&& chmod u+x nvim.appimage \
		&& ln -sf nvim.appimage nvim

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
	mkdir -p $(INSTALL_DIR)
	mv coursier $(INSTALL_DIR)/coursier
	chmod u+x $(INSTALL_DIR)/coursier
	$(INSTALL_DIR)/coursier setup --install-dir $(INSTALL_DIR)

.PHONY: lastpass_install
lastpass_install:
	rm -rf lastpass-cli && git clone --depth=1 https://github.com/lastpass/lastpass-cli
	mkdir -p $(INSTALL_DIR)
	cd lastpass-cli && make && PREFIX=$(dir $(INSTALL_DIR)) make install

.PHONY: nodejs_install
nodejs_install:
	curl -LO https://nodejs.org/dist/v20.11.0/node-v20.11.0-linux-x64.tar.xz
	mkdir -p $(INSTALL_DIR)
	tar -xvf node-v20.11.0-linux-x64.tar.xz --strip-components=1 -C $(dir $(INSTALL_DIR))

.PHONY: ripgrep_install
ripgrep_install:
	curl -LO https://github.com/BurntSushi/ripgrep/releases/download/14.1.0/ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz
	mkdir -p $(INSTALL_DIR)
	tar -xvf ripgrep-14.1.0-x86_64-unknown-linux-musl.tar.gz --strip-components=1 -C $(INSTALL_DIR)
