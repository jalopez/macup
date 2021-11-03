#!/bin/bash

# Stolen miserably from brew installer
should_install_command_line_tools() {
    ! [[ -e "/Library/Developer/CommandLineTools/usr/bin/git" ]]
}

abort() {
    printf "%s\n" "$1"
    exit 1
}

chomp() {
    printf "%s" "${1/"$'\n'"/}"
}

execute() {
    if ! "$@"; then
        abort "$(printf "Failed during: %s" "$(shell_join "$@")")"
    fi
}

execute_sudo() {
    local -a args=("$@")
    if [[ -n "${SUDO_ASKPASS-}" ]]; then
        args=("-A" "${args[@]}")
    fi
    if have_sudo_access; then
        echo "/usr/bin/sudo" "${args[@]}"
        execute "/usr/bin/sudo" "${args[@]}"
    else
        echo "${args[@]}"
        execute "${args[@]}"
    fi
}

getc() {
    local save_state
    save_state=$(/bin/stty -g)
    /bin/stty raw -echo
    IFS= read -r -n 1 -d ''
    /bin/stty "$save_state"
}

install_git() {
    if should_install_command_line_tools; then
        echo "The Xcode Command Line Tools will be installed."
        # This temporary file prompts the 'softwareupdate' utility to list the Command Line Tools
        clt_placeholder="/tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress"
        execute_sudo "$TOUCH" "$clt_placeholder"
        
        clt_label_command="/usr/sbin/softwareupdate -l |
        grep -B 1 -E 'Command Line Tools' |
        awk -F'*' '/^ *\\*/ {print \$2}' |
        sed -e 's/^ *Label: //' -e 's/^ *//' |
        sort -V |
        tail -n1"
        clt_label="$(chomp "$(/bin/bash -c "$clt_label_command")")"
        
        if [[ -n "$clt_label" ]]; then
            echo "Installing $clt_label"
            execute_sudo "/usr/sbin/softwareupdate" "-i" "$clt_label"
            execute_sudo "/bin/rm" "-f" "$clt_placeholder"
            execute_sudo "/usr/bin/xcode-select" "--switch" "/Library/Developer/CommandLineTools"
        fi
    fi
    
    if should_install_command_line_tools && test -t 0; then
        echo "Installing the Command Line Tools (expect a GUI popup):"
        execute_sudo "/usr/bin/xcode-select" "--install"
        echo "Press any key when the installation has completed."
        getc
        execute_sudo "/usr/bin/xcode-select" "--switch" "/Library/Developer/CommandLineTools"
    fi
}


if [[ -d "$HOME/.macup" ]]; then
    echo "Mac up already installed. Updating it"
    macup update
else
    install_git
    
    git clone https://github.com/jalopez/macup.git ~/.macup
    
    if [[ ":${PATH}:" != *"$HOME/.macup/bin:"* ]]; then
        
        echo 'test -e $HOME/.macup/configure.sh && . $HOME/.macup/configure.sh' >> ~/.zshrc
        . $HOME/.macup/configure.sh
    fi
    
    echo "Successfully installed macup."
fi

echo "Your backup path is set to ~/Dropbox/dotfiles/macup"
echo 'You can modify this config by changing $MACUP_BACKUP_PATH env variable'

macup setup

echo "Macup properly configured! run 'macup -h' to see options"
