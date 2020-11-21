#/bin/zsh

function cmd_restore {
  require_macup_configured
  require_backup_folder || exit 1
  print_header

  echo "--- Restoring backup ---"
  echo "Reading files from $MACUP_BACKUP_PATH"

  echo "1. brew apps"
  (cd "$MACUP_BACKUP_PATH" && brew bundle)

  echo "2. mac user preferences"
  MACPREFS_BACKUP_DIR="$MACUP_BACKUP_PATH/macprefs" macprefs restore

  echo "3. dotfiles"
  (cd ~ && dotsync)

  echo "4. custom postinstall script"
  [[ -f  $MACUP_BACKUP_PATH/postinstall.sh ]] && zsh $MACUP_BACKUP_PATH/postinstall.sh

  echo "Restore successfully done. Enjoy!"
}
