#!/bin/bash

function sub_update() {
  print_header
  echo ". Updating macup scripts ."

  cd ~/.macup
  git update

  echo "OK"
}
