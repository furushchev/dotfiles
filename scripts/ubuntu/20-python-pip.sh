#!/bin/bash

if [ "`which pip`" != "" ]; then
  return
fi

dpkg -s python-setuptools 1>/dev/null 2>&1
if [ $? -ne 0 ]; then
  sudo apt-get install -y -q -qq install python-setuptools
fi

sudo easy_install pip
sudo pip install -U pip setuptools

