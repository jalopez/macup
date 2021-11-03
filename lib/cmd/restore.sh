#!/bin/bash

function cmd_restore {
    require_macup_configured
    require_backup_folder || exit 1
    print_header
    
    lightblue "--- Restoring backup ---"
    echo -n "Reading files from "
    green "$MACUP_BACKUP_PATH"
    
    lightblue "1. brew apps"
    (cd "$MACUP_BACKUP_PATH" && brew bundle -v)
    
    lightblue "2. mac user preferences"
    MACPREFS_BACKUP_DIR="$MACUP_BACKUP_PATH/macprefs" macprefs restore
    
    lightblue "3. dotfiles"
    (cd ~ && dotsync -f)
    
    lightblue "4. custom postinstall script"
    [[ -f  $MACUP_BACKUP_PATH/postinstall.sh ]] && zsh "$MACUP_BACKUP_PATH/postinstall.sh"
    
    green "Restore successfully done. Enjoy!"
}
