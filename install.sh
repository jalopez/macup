#!/bin/bash
if [[ -d "$HOME/.macup" ]]; then
  echo "Mac up already installed. Updating it"
  macup update
else
  git clone git@github.com:jalopez/macup.git ~/.macup

  echo ""
  echo "Successfully installed macup."

  if [[ ":${PATH}:" != *"$HOME/.macup/bin:"* ]]; then
    echo "Adding macup binary to your PATH"
    echo 'export PATH=$PATH:~/.macup/bin' >> ~/.zshrc
    export PATH=$PATH:~/.macup/bin
  fi
fi

set -o nounset

BACKUP_PATH=${MACUP_BACKUP_PATH:-}

if [[ -z $BACKUP_PATH ]]; then
  echo "Setting your backup path to ~/Dropbox/dotfiles/macup"
  echo 'You can modify this config by changing MACUP_BACKUP_PATH env variable'
  echo 'export MACUP_BACKUP_PATH=~/Dropbox/dotfiles/macup' >> ~/.zshrc
  export MACUP_BACKUP_PATH=~/Dropbox/dotfiles/macup
fi

macup setup
