#!/bin/bash

require_env() {
  local env_var_name="$1"

  if [ "unset" == "${!env_var_name:-unset}" ]; then
    echo "'${env_var_name}' env var is missing, aborting"
    exit 1
  fi
}

require_command() {
  local command="$1"

  command -v "${command}" >/dev/null 2>&1 && echo "${command} already present, skipping" || exit 1
}

require_app() {
  local app="$1"

  if [[ -d "/Applications/${app}.app" ]]; then
    echo "${app} already present, skipping"
  else
    exit 1
  fi
}

print_header() {
  echo "************************"
  echo "*   MACUP backup tool  *"
  echo "************************"
}

require_macup_configured() {
  if [[ ! -f ~/.macup/.depsinstalled ]]; then
    echo "Macup is not properly configured"
    echo "please run 'macup setup' before running this command"
    exit 1
  fi
}
