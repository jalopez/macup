#/bin/bash

function prepare_restore {
  echo "Missing requirements for restoring your backup"
  echo ". Installing requirements ."

  echo "1. brew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  echo "2. volta"
  curl https://get.volta.sh | bash

  echo "3. dotsync"
  volta install node
  volta install dotsync

  echo "4. mac preferences restoring tool"
  brew install clintmod/formulas/macprefs

  echo "5. Dropbox"
  brew cask install dropbox

  echo "Restore requirements successfully installed"
  echo "Remember to configure your dropbox account and then run this command again"
}

function run_restore {
  echo "TODO"
}

function cmd_restore {
  if [[ -f ~/.macup/.restoreconfigured ]]; then
    if [[ -d $MACUP_BACKUP_PATH ]]; then
      run_restore
    else
      echo "Cannot find $MACUP_BACKUP_PATH. Did you configure your dropbox account?"
      echo "Aborting"
      exit 1
    fi
  else
    prepare_restore
  fi
}
