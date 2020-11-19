#/bin/bash

echo ".....RESTORING (Step 1)....."

echo "- Installing brew"
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"

echo "- Installing volta"
curl https://get.volta.sh | bash

echo "- Installing node and basic deps"
volta install node
volta install dotsync

echo "- Installing asdf"
brew install asdf

echo "- Installing basic apps"
brew cask install dropbox iterm2-beta


echo ".... STEP 1 FINISHED ...."

echo "REMEMBER: Before running step 2, you need to..."
echo "- Log in into Dropbox (if it is your macup file location)"
echo "- Configure iTerm2"
