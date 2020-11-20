#/bin/bash

function cmd_setup {
  print_header
  echo "--- Installing requirements ---"

  echo "1. brew"
  require_command "brew" || /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

  echo "2. volta"
  require_command "volta" || curl https://get.volta.sh | bash

  echo "3. node"
  require_command "node" || volta install node

  echo "4. dotsync"
  require_command "dotsync" || volta install dotsync

  echo "5. macprefs"
  require_command "macprefs" || brew install clintmod/formulas/macprefs

  echo "6. Dropbox"
  require_app "Dropbox" || brew cask install dropbox

  touch ~/.macup/.depsinstalled

  echo "macup requirements successfully installed"
  echo "You can start backuping or restoring now"
}
