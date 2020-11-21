#!/bin/zsh

function cmd_backup() {
  require_macup_configured
  print_header

  echo "--- Running backup ---"
  echo "Saving files into $MACUP_BACKUP_PATH"

  echo "1. brew apps"
  (cd "$MACUP_BACKUP_PATH" && brew bundle dump -f)

  echo "2. mac user preferences"
  MACPREFS_BACKUP_DIR="$MACUP_BACKUP_PATH/macprefs" macprefs backup

  # Removing files handled by dotsync
  rm -rf $MACUP_BACKUP_PATH/macprefs/dotfiles/*
  rm -rf $MACUP_BACKUP_PATH/macprefs/ssh/*
}
