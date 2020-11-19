#!/bin/bash

function help() {
    echo "Usage: $prog_name <subcommand> [options]\n"
    echo "Subcommands:"
    echo "    backup   Create or update backup"
    echo "    restore  Restore a backup"
    echo "    update   Update macup scripts"
    echo ""
    echo "For help with each subcommand run:"
    echo "$prog_name <subcommand> -h|--help"
    echo ""
}

require_env() {
  local env_var_name="$1"

  if [ "unset" == "${!env_var_name:-unset}" ]; then
    echo "'${env_var_name}' env var is missing, aborting"
    help
    exit 1
  fi
}

print_header() {
  echo "************************"
  echo "*   MACUP backup tool  *"
  echo "************************"
}
