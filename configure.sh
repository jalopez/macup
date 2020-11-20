#!/bin/bash

if [[ ":${PATH}:" != *"$HOME/.macup/bin:"* ]]; then
  export PATH=$PATH:~/.macup/bin
fi

if [[ -z "$MACUP_BACKUP_PATH" ]]; then
  export MACUP_BACKUP_PATH=~/Dropbox/dotfiles/macup
fi

