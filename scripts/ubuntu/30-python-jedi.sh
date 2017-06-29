#!/bin/bash

python -m jedi 2>/dev/null
if [ $? -eq 0 ]; then
  return
fi

sudo pip install -U jedi
