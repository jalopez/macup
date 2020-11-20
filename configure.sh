#!/bin/bash
set -o nounset

if [[ ":${PATH}:" != *"$HOME/.macup/bin:"* ]]; then
  export PATH=$PATH:~/.macup/bin
fi

BACKUP_PATH=${MACUP_BACKUP_PATH:-}

if [[ -z $BACKUP_PATH ]]; then
  export MACUP_BACKUP_PATH=~/Dropbox/dotfiles/macup
fi

