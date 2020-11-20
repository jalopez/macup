#/bin/bash

function cmd_restore {
  require_macup_configured
  print_header

  if [[ -d $MACUP_BACKUP_PATH ]]; then
    echo "--- Restoring backup ---"
    echo "Reading files from $MACUP_BACKUP_PATH"

    echo "1. brew apps"
    (cd "$MACUP_BACKUP_PATH" && brew bundle)

    echo "2. mac user preferences"
    MACPREFS_BACKUP_DIR="$MACUP_BACKUP_PATH/macprefs" macprefs restore

    echo "3. dotfiles"
    (cd ~ && dotsync)

    echo "Restore successfully done. Enjoy!"
  else
    echo "Cannot find $MACUP_BACKUP_PATH. Do you have everything configured?"
    echo "Aborting"
    exit 1
  fi
}
