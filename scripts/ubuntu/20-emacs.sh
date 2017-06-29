#!/bin/bash

dpkg -s emacs24-nox 1>/dev/null 2>&1
if [ $? -eq 0 ]; then
  return
fi

sudo apt-get install -y -q -qq install emacs24-nox
(emacs -batch --eval '(setq debug-on-error t)' -l $HOME/.emacs.d/init.el)
