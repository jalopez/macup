#!/bin/bash

function cmd_update() {
  print_header
  lightblue ". Updating macup scripts ."

  cd ~/.macup
  git pull origin main
}
