#!/bin/bash
if [[ -d "$HOME/.macup" ]]; then
  echo "Mac up already installed. Updating it"
  macup update
else
  git clone https://github.com/jalopez/macup.git ~/.macup

  if [[ ":${PATH}:" != *"$HOME/.macup/bin:"* ]]; then
    echo 'test -e $HOME/.macup/configure.sh && . $HOME/.macup/configure.sh' >> ~/.zshrc
    . ~/.macup/configure.sh
  fi

   echo "Successfully installed macup."
fi

echo "Your backup path is set to ~/Dropbox/dotfiles/macup"
echo 'You can modify this config by changing $MACUP_BACKUP_PATH env variable'

macup setup

echo "Macup properly configured! run 'macup -h' to see options"
