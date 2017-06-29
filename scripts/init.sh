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

CURRENT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}"); pwd)

if [ "$(uname)" = "Darwin" ]; then
  DISTRO=darwin
elif [ -e /etc/lsb-release ]; then
  if [ "`lsb_release -is`" = "Ubuntu" ]; then
    DISTRO=ubuntu
  fi
fi

if [ -d $CURRENT_DIR/$DISTRO ]; then
  for i in $CURRENT_DIR/$DISTRO/*.sh; do
    if [ -r $i ]; then
      prompt info "Installing $(basename $i)"
      . $i
    fi
  done
  unset i
fi

unset CURRENT_DIR
unset DISTRO
