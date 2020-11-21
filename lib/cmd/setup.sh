#/bin/zsh

function cmd_setup {
  print_header
  echo "--- Installing requirements ---"

  echo "1. brew"
  require_command "brew" || /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  echo "2. volta / node"
  require_command "volta" || ((curl https://get.volta.sh | bash) && export PATH=$PATH:~/.volta/bin && volta install node)

  echo "3. dotsync"
  require_command "dotsync" || volta install dotsync

  echo "4. macprefs"
  require_command "macprefs" || brew install clintmod/formulas/macprefs

  echo "5. Dropbox"
  require_app "Dropbox" || brew cask install dropbox

  touch ~/.macup/.depsinstalled

  echo "macup requirements successfully installed"
  require_backup_folder && echo "You can start backuping or restoring now"
}
