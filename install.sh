#!/bin/sh
set -ex

DOTFILES=`pwd`

git config --global user.name "Mario Rogic"
git config --global user.email hello@mario.net.au

# How to figure out what UI settings correspond to what
# defaults read > defaults.txt
# ### change the thing
# defaults read > defaults2.txt
# icdiff defaults.txt defaults2.txt

defaults write com.apple.finder AppleShowAllFiles YES
killall Finder # Doesn't take effect unless we restart


# These should work but don't seem to... why? Seems like it should? None of this advice worked
# https://eclecticlight.co/2022/11/25/changing-preferences-isnt-so-simple/
# https://apple.stackexchange.com/questions/331537/preferences-changes-using-defaults-not-applied
# https://stackoverflow.com/questions/75272685/defaults-write-in-macos-never-writes-or-changes-the-value-in-defaults
#
# Last one is our exact example... trying to set Trackpad settings
defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2
defaults write -g "com.apple.swipescrolldirection" -bool false


defaults -currentHost write com.apple.mouse tapBehavior -bool true
plutil -replace Clicking -bool YES ~/Library/Preferences/com.apple.AppleMultitouchTrackpad.plist
defaults import com.apple.AppleMultitouchTrackpad ~/Library/Preferences/com.apple.AppleMultitouchTrackpad.plist



link() {
  # Force create/replace the symlink
  ln -fs "${1}" "${HOME}/${2}"
  echo "${1} -> ${2}"
}

link "${DOTFILES}/zshrc"     ".zshrc"
link "${DOTFILES}/vimrc"     ".vimrc"
link "${DOTFILES}/gitconfig" ".gitconfig"
link "${DOTFILES}/iterm2_shell_integration.zsh" ".iterm2_shell_integration.zsh"
#link "${DOTFILES}/tmux.conf" ".tmux.conf"

#link "${HOME}/Dropbox/dev"   "dev"

# Install ohmyzsh
if [[ ! -d ~/.oh-my-zsh ]]; then
  sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

link "${DOTFILES}/min.zsh-theme"   ".oh-my-zsh/themes/min.zsh-theme"

SOLARIZED="${DOTFILES}/solarized"
if [[ ! -d ${SOLARIZED} ]]; then
  # Install solarized theme
  git clone git@github.com:altercation/solarized.git $SOLARIZED
fi

SOLARIZED_VIM="${HOME}/.vim/colors/solarized.vim"
if [[ ! -f ${SOLARIZED_VIM} ]]; then
  mkdir -p "${HOME}/.vim/colors"
  cp "${SOLARIZED}/vim-colors-solarized/colors/solarized.vim" $SOLARIZED_VIM
fi

# Install tokyonight theme

# Install rosetta (still required for some things, i.e. sorbet)
ROSETTA_INSTALLED=$(pkgutil --pkg-info com.apple.pkg.RosettaUpdateAuto | grep install-time)
if [[ -z ${ROSETTA_INSTALLED} ]]; then
  softwareupdate --install-rosetta
fi

# Install homebrew
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Brewfile
brew bundle

# Install devbox
if ! command -v devbox &> /dev/null; then
  curl -fsSL https://get.jetify.com/devbox | bash
fi

if [[ ! -e ~/Library/Application\ Support/LibreWolf/NativeMessagingHosts ]]; then
  open /Applications/LibreWolf.app
  # Wait for 5 seconds
  sleep 3
  # Enable Native Messaging
  # https://librewolf.net/docs/faq/#how-do-i-get-native-messaging-to-work-1
  ln -s ~/Library/Application\ Support/Mozilla/NativeMessagingHosts ~/Library/Application\ Support/LibreWolf/NativeMessagingHosts
fi

# Manual stuff documented here:
# https://www.notion.so/realmario/Mac-restore-setup-install-8636630a79184f2b9ac736487e2eafed?pvs=4
