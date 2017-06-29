DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUDES   := .DS_Store .git .gitmodules .travis.yml
DOTFILES   := $(filter-out $(EXCLUDES), $(CANDIDATES))

YELLOW     := "\033[1;33m"
RESET      := "\033[0m"

.DEFAULT_GOAL := help
.PHONY: all list deploy update clean help

all:

list:
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

deploy:
	@echo $(YELLOW)'>>>> Create symlinks to home directory'$(RESET)
	@echo ''
	@$(foreach val, $(DOTFILES), ln -sfnv $(abspath $(val)) $(HOME)/$(val);)
	@echo $(YELLOW)'<<<< Created symlinks'$(RESET)
	@echo ''

init:
	@echo $(YELLOW)'>>>> Setting up initialization scripts'$(RESET)
	@echo ''
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/scripts/init.sh
	@echo $(YELLOW)'<<<< Finished setting up initialization scripts'$(RESET)
	@echo ''

update:
	@echo $(YELLOW)'>>>> Fetching latest configuration'$(RESET)
	git pull --recurse-submodules origin master
	@echo $(YELLOW)'<<<< Finished fetching latest configuration'$(RESET)

install: update deploy init
	@echo $(YELLOW)'Successfully Installed.'$(RESET)
	@echo $(YELLOW)'Reopen terminal or "source ~/.bashrc"'$(RESET)

clean:
	@echo $(YELLOW)'>>>> Removing symlinks'$(RESET)
	@-$(foreach val, $(DOTFILES), rm -ivrf $(HOME)/$(val);)
	-rm -irf $(DOTPATH)
	@echo $(YELLOW)'<<<< Removed symlinks'$(RESET)

help:
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'
