#!/bin/bash

function cmd_backup() {
    require_macup_configured
    print_header
    
    lightblue "--- Running backup ---"
    echo -n "Saving files into "
    green "$MACUP_BACKUP_PATH"
    
    lightblue "1. brew apps"
    (cd "$MACUP_BACKUP_PATH" && brew bundle dump -f)
    
    lightblue "2. mac user preferences"
    MACPREFS_BACKUP_DIR="$MACUP_BACKUP_PATH/macprefs" macprefs backup
    
    # Removing files handled by dotsync
    rm -rf $MACUP_BACKUP_PATH/macprefs/dotfiles/*
    rm -rf $MACUP_BACKUP_PATH/macprefs/ssh/*
}
