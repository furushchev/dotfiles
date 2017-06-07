#!/bin/bash

CURRENT_DIR=$(cd $(dirname "${BASH_SOURCE[0]}"); pwd)

if [ "$(uname)" = "Darwin" ]; then
  exec $CURRENT_DIR/darwin/init.sh
else
  if [ -e /etc/lsb-release ]; then
    if [ "`lsb_release -is`" != "Ubuntu" ]; then
      echo "Only Ubuntu is supported!"
      exit 1
    fi
  else
    echo "Only debian based linux is supported!"
    exit 1
  fi

  exec $CURRENT_DIR/ubuntu/init.sh
fi
