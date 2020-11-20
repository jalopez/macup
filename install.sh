#!/bin/bash
if [[ -d "$HOME/.macup" ]]; then
  echo "Mac up already installed. Updating it"
  macup update
else
  git clone git@github.com:jalopez/macup.git ~/.macup

  echo "Successfully installed macup."

  if [[ ":${PATH}:" != *"$HOME/.macup/bin:"* ]]; then
    echo 'source ~/.macup/configure.sh' >> ~/.zshrc
    source ~/.macup/configure.sh
  fi
fi

echo "Your backup path is set to ~/Dropbox/dotfiles/macup"
echo 'You can modify this config by changing $MACUP_BACKUP_PATH env variable'

macup setup

echo "Macup properly configured! run 'macup -h' to see options"
