ROOT := $(shell pwd)
SYMLINK := ln -fns

all: bash bin mutt tcsh vim

bash:
	$(SYMLINK) $(ROOT)/.bash_login $(HOME)/.bash_login
	$(SYMLINK) $(ROOT)/.bashrc $(HOME)/.bashrc
	$(SYMLINK) $(ROOT)/.inputrc $(HOME)/.inputrc

bin:
	mkdir -p $(HOME)/bin
	$(SYMLINK) $(ROOT)/modules/git-wip/git-wip $(HOME)/bin/git-wip

mutt:
	$(SYMLINK) $(ROOT)/.muttrc $(HOME)/.muttrc

tcsh:
	$(SYMLINK) $(ROOT)/.tcsh $(HOME)/.tcsh
	$(SYMLINK) $(ROOT)/.tcshrc $(HOME)/.tcshrc

vim:
	$(SYMLINK) $(ROOT)/.vim $(HOME)/.vim
	$(SYMLINK) $(ROOT)/.vimrc $(HOME)/.vimrc
