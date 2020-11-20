#/bin/bash


function run_restore {
  echo "TODO"
}

function cmd_restore {
  require_macup_configured
  print_header

  if [[ -d $MACUP_BACKUP_PATH ]]; then
    run_restore
  else
    echo "Cannot find $MACUP_BACKUP_PATH. Do you have everything configured?"
    echo "Aborting"
    exit 1
  fi
}
