ROOT := $(shell pwd)
SYMLINK := ln -fns
EMAIL := $(shell git config user.email || echo conor@mcdermottroe.com)

# Entry point targets
all: bash bin git mutt tcsh vim

# Different modules
bash:
	$(SYMLINK) $(ROOT)/.bash_login $(HOME)/.bash_login
	$(SYMLINK) $(ROOT)/.bashrc $(HOME)/.bashrc
	$(SYMLINK) $(ROOT)/.inputrc $(HOME)/.inputrc

bin: $(HOME)/bin
	$(SYMLINK) $(ROOT)/modules/git-wip/git-wip $(HOME)/bin/git-wip

git: $(ROOT)/.gitconfig
	$(SYMLINK) $(ROOT)/.gitconfig $(HOME)/.gitconfig

mutt:
	$(SYMLINK) $(ROOT)/.muttrc $(HOME)/.muttrc

tcsh:
	$(SYMLINK) $(ROOT)/.tcsh $(HOME)/.tcsh
	$(SYMLINK) $(ROOT)/.tcshrc $(HOME)/.tcshrc

vim:
	$(SYMLINK) $(ROOT)/.vim $(HOME)/.vim
	$(SYMLINK) $(ROOT)/.vimrc $(HOME)/.vimrc

# Utility targets
$(HOME)/bin:
	mkdir -p $(HOME)/bin

$(ROOT)/.gitconfig: .gitconfig.template
	sed -e "s/___EMAIL___/$(EMAIL)/" < $(ROOT)/.gitconfig.template > $(ROOT)/.gitconfig
