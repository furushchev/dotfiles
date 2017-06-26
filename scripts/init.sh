#!/bin/bash

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
      . $i
    fi
  done
  unset i
fi

unset CURRENT_DIR
unset DISTRO
