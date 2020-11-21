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

  command -v "${command}" >/dev/null 2>&1 && echo "${command} already present, skipping"
}

require_app() {
  local app="$1"

  [[ -d "/Applications/${app}.app" ]] && echo "${app} already present, skipping"
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

require_backup_folder() {
  if [[ ! -d $MACUP_BACKUP_PATH ]]; then
    echo "It seems that your backup folder $MACUP_BACKUP_PATH doesn't exist"
    echo "Do you have dropbox already configured?"
    echo 'Please configure it or point $MACUP_BACKUP_PATH to a valid folder'
    return 1
  fi
  return 0
}
