#/bin/bash

echo ".....MACUP backup starting....."

BACKUP_TARGET=${MACUP_HOME:-"$HOME/Dropbox/dotfiles/macup"}

echo "Saving files into $BACKUP_TARGET"

echo "- Copying fonts"
mkdir -p "$BACKUP_TARGET/Fonts"
cp  ~/Library/Fonts/* "$BACKUP_TARGET/Fonts"

echo "- Saving Brewconfig"
(cd "$BACKUP_TARGET" && rm Brewfile && brew bundle dump)

echo "- Saving mac config"
MACPREFS_BACKUP_DIR="$BACKUP_TARGET/macprefs" macprefs backup
rm -rf $BACKUP_TARGET/macprefs/dotfiles/*
