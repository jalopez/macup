#!/bin/bash

function cmd_update() {
  print_header
  echo ". Updating macup scripts ."

  cd ~/.macup
  git update

  echo "OK"
}
