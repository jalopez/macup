#!/bin/bash
set -u

if [[ -d "$HOME/.macup" ]]; then
  echo "Mac up already installed. You can run macup update to update to latest version"
else
  git clone git@github.com:jalopez/macup.git ~/.macup
fi

if [[ ":${PATH}:" != *"$HOME/.macup/bin:"* ]]; then
  echo "Adding macup binary to your PATH"
  echo 'export PATH=$PATH:~/.macup/bin' >> .zshrc
fi

echo "Successfully installed macup. "
echo "To start backing up, open a new terminal session and run"
echo "macup -h to see options"
