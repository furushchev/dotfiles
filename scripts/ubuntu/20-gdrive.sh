#!/bin/bash

if [ "`which gdrive`" != "" ]; then
  return
fi

wget -O /tmp/gdrive "https://docs.google.com/uc?id=0B3X9GlR6EmbnQ0FtZmJJUXEyRTA&export=download"
sudo install -m 755 /tmp/gdrive /usr/local/bin/gdrive
