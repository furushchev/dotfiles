#!/bin/bash

install_app() {
  PKG=$1
  dpkg -s $PKG 1>/dev/null 2>&1
  PKG_EXISTS=$?
  if [ $PKG_EXISTS -ne 0 ]; then
    sudo apt-get -y -q -qq install $PKG
  fi
}

install_app wget
install_app curl
install_app sysstat
install_app dstat
install_app iperf
