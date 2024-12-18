#!/bin/bash

function cmd_setup {
    print_header
    lightblue "--- Installing requirements ---"

    lightblue "1. brew"
    if ! require_command "brew"; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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
        /usr/local/bin/brew install sijanc147/formulas/macprefs
    fi

    touch ~/.macup/.depsinstalled

    green "macup requirements successfully installed"
    require_backup_folder && green "You can start backuping or restoring now"
}
