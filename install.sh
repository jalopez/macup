#!/bin/bash
set -u

if [[ -d "$HOME/.macup" ]]; then
  echo "Mac up already installed. You can run macup update to update to latest version"
else
  git clone git@github.com:jalopez/macup.git ~/.macup

  echo ""
  echo "Successfully installed macup."

  if [[ ":${PATH}:" != *"$HOME/.macup/bin:"* ]]; then
    echo "Adding macup binary to your PATH"
    echo 'export PATH=$PATH:~/.macup/bin' >> .zshrc
  fi
fi

if [[ -z "$MACUP_BACKUP_PATH" ]]; then
  echo "Setting your backup path to ~/Dropbox/dotfiles/macup"
  echo 'You can modify this config by changing $MACUP_BACKUP_PATH env variable'
  echo 'export MACUP_BACKUP_PATH=~/Dropbox/dotfiles/macup' >> .zshrc
fi

echo "To start backing up, open a new terminal session and run"
echo "macup -h to see options"
