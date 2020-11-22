#/bin/bash

function cmd_setup {
  print_header
  lightblue "--- Installing requirements ---"

  lightblue "1. brew"
  if ! require_command "brew"; then
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
  fi

  lightblue "2. volta / node"
  if ! require_command "volta"; then
    curl https://get.volta.sh | bash
    ~/.volta/bin/volta install node
  fi

  lightblue "3. dotsync"
  if ! require_command "dotsync"; then
    ~/.volta/bin/volta install dotsync
  fi

  lightblue "4. macprefs"
  if ! require_command "macprefs"; then
    /usr/local/bin/brew install clintmod/formulas/macprefs
    ## published version doesnt work with python 3, bring the latest one
    rm -rf /usr/local/Cellar/macprefs/1.0.26/bin/*
    git clone https://github.com/clintmod/macprefs.git /usr/local/Cellar/macprefs/1.0.26/bin
  fi

  lightblue "5. Dropbox"
  if ! require_app "Dropbox"; then
    /usr/local/bin/brew cask install dropbox
  fi

  touch ~/.macup/.depsinstalled

  green "macup requirements successfully installed"
  require_backup_folder && green "You can start backuping or restoring now"
}
