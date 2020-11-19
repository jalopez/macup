#!/bin/bash
git clone git@github.com:jalopez/macup.git ~/.macup

if [[ ":${PATH}:" != *":~/.macup/bin:"* ]]; then
  echo "~/.macup/bin is not in your PATH. adding it"
  echo "export PATH=$PATH:~/.macup/bin >> .zsh"
fi

echo "Successfully installed macup. To start backing up, run macup in your console"
