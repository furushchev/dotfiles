#!/bin/bash

if [ "`which hub`" != "" ]; then
  return
fi

brew install hub
