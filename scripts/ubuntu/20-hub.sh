#!/bin/bash

if [ "`which hub`" != "" ]; then
  return
fi

FILE=hub-linux-amd64-2.2.9
curl -o /tmp/hub.tgz -L https://github.com/github/hub/releases/download/v2.2.9/${FILE}.tgz
(cd /tmp && tar xf hub.tgz)
(sudo /tmp/${FILE}/install)
