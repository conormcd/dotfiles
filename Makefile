ROOT := $(shell pwd)
SYMLINK := ln -fns

all: tcsh vim

tcsh:
	$(SYMLINK) $(ROOT)/.tcsh $(HOME)/.tcsh
	$(SYMLINK) $(ROOT)/.tcshrc $(HOME)/.tcshrc

vim:
	$(SYMLINK) $(ROOT)/.vim $(HOME)/.vim
	$(SYMLINK) $(ROOT)/.vimrc $(HOME)/.vimrc
