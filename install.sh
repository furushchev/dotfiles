#!/bin/bash

prompt() {
  level="$1"
  RESET="\033[0m"
  if [ $level = "err" ]; then
    START="\033[1;31m"
  elif [ $level = "warn" ]; then
    START="\033[1;33m"
  elif [ $level = "info" ]; then
    START="\033[1;32m"
  fi
  shift
  echo -e "$START$@$RESET"
}

_apt_updated=false
apt_install() {
  if [ "$_apt_updated" = "false" ]; then
    sudo apt-get -y -q -qq update
    _apt_updated=true
  fi
  sudo apt-get -y -q -qq install $@
}

# check DOTPATH variable
if [ -z "$DOTPATH" ]; then
  export DOTPATH="$HOME/.dotfiles"
fi

prompt info "DOTPATH is set to $DOTPATH"

# check git
if [ "$(which git)" = "" ]; then
  prompt warn "git not found. Installing..."
  apt_install git
fi

# check make
if [ "$(which make)" = "" ]; then
  prompt warn "make not found, Installing..."
  apt_install make
fi

# check repository
if [ ! -d "$DOTPATH" ]; then
  prompt info "Repository not found. Downloading..."
  git clone https://github.com/furushchev/dotfiles --recursive $DOTPATH
fi

# install
prompt info "Installing..."
(cd "$DOTPATH" && make install)
