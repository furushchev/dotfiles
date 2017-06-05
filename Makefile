DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUDES   := .DS_Store .git .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUDES), $(CANDIDATES))

.DEFAULT_GOAL := help
.PHONY: all list deploy update clean help

all:

list:
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

deploy:
	@echo '>>>> Create symlinks to home directory'
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@echo '<<<< Created symlinks'
	@echo ''

init:
	@echo '>>>> Setting up initialization scripts'
	@echo ''
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/scripts/init.sh
	@echo '<<<< Finished setting up initialization scripts'
	@echo ''

update:
	git pull --recurse-submodules origin master

install: update deploy init
	@exec -l $$SHELL

clean:
	@echo '>>>> Removing symlinks'
	@-$(foreach val, $(DOTFILES), rm -ivrf $(HOME)/$(val);)
	-rm -irf $(DOTPATH)

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
