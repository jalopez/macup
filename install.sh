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

unset HAVE_SUDO_ACCESS # unset this from the environment

have_sudo_access() {
    if [[ ! -x "/usr/bin/sudo" ]]; then
        return 1
    fi

    local -a SUDO=("/usr/bin/sudo")
    if [[ -n "${SUDO_ASKPASS-}" ]]; then
        SUDO+=("-A")
    elif [[ -n "${NONINTERACTIVE-}" ]]; then
        SUDO+=("-n")
    fi

    if [[ -z "${HAVE_SUDO_ACCESS-}" ]]; then
        if [[ -n "${NONINTERACTIVE-}" ]]; then
            "${SUDO[@]}" -l mkdir &>/dev/null
        else
            "${SUDO[@]}" -v && "${SUDO[@]}" -l mkdir &>/dev/null
        fi
        HAVE_SUDO_ACCESS="$?"
    fi

    if [[ "${HAVE_SUDO_ACCESS}" -ne 0 ]]; then
        abort "Need sudo access (e.g. the user ${USER} needs to be an Administrator)!"
    fi

    return "${HAVE_SUDO_ACCESS}"
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

    CONFIGURE_PATH="$HOME/.macup/configure.sh"
    CONFIGURE_PATH_TEMPLATE="$HOME/.macup/configure.sh.template"

    if [[ -z $MACUP_BACKUP_PATH ]]; then
        echo "Backup path not set. Which path do you want to use for backups?"
        read -r MACUP_BACKUP_PATH
        cp "$CONFIGURE_PATH_TEMPLATE" "$CONFIGURE_PATH"

        cat >>"$CONFIGURE_PATH" <<EOF
if [[ -z "\$MACUP_BACKUP_PATH" ]]; then
  export MACUP_BACKUP_PATH=$MACUP_BACKUP_PATH
fi
EOF
    fi

    if [[ ":${PATH}:" != *"$HOME/.macup/bin:"* ]]; then
        echo "test -e \$HOME/.macup/configure.sh && . \$HOME/.macup/configure.sh" >>~/.zshrc
        # shellcheck disable=SC1090
        . "$CONFIGURE_PATH"
    fi

    echo "Successfully installed macup."
fi

echo "Your backup path is set to $MACUP_BACKUP_PATH"
echo "You can modify this config by changing \$MACUP_BACKUP_PATH env variable"

macup setup

echo "Macup properly configured! run 'macup -h' to see options"
