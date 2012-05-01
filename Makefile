ROOT := $(shell pwd)
SYMLINK := ln -fns

all: mutt tcsh vim

mutt:
	$(SYMLINK) $(ROOT)/.muttrc $(HOME)/.muttrc

tcsh:
	$(SYMLINK) $(ROOT)/.tcsh $(HOME)/.tcsh
	$(SYMLINK) $(ROOT)/.tcshrc $(HOME)/.tcshrc

vim:
	$(SYMLINK) $(ROOT)/.vim $(HOME)/.vim
	$(SYMLINK) $(ROOT)/.vimrc $(HOME)/.vimrc
