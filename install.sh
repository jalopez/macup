#!/bin/bash
set -up
git clone git@github.com:jalopez/macup.git ~/.macup

if [[ ":${PATH}:" != *".macup/bin:"* ]]; then
  echo "~/.macup/bin is not in your PATH. adding it"
  echo 'export PATH=$PATH:~/.macup/bin' >> .zshrc
fi

echo "Successfully installed macup. To start backing up, open a new session and run"
echo "- macup for backing up"
echo "- macup-restore for restoring a backup"
