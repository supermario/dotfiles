#!/bin/sh
set -ex

DOTFILES=`pwd`

git config --global user.name "Mario Rogic"
git config --global user.email hello@mario.net.au

defaults write -g InitialKeyRepeat -int 15
defaults write -g KeyRepeat -int 2

# Would be nice to extend for other stuff, see `defaults read`
# - Enable the trackpad touch to click

link() {
  # Force create/replace the symlink
  ln -fs "${1}" "${HOME}/${2}"
  echo "${1} -> ${2}"
}

link "${DOTFILES}/zshrc"     ".zshrc"
link "${DOTFILES}/vimrc"     ".vimrc"
link "${DOTFILES}/gitconfig" ".gitconfig"
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

# Install homebrew
if ! command -v brew &> /dev/null; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Install Brewfile
brew bundle


if ! command -v devbox &> /dev/null; then
  curl -fsSL https://get.jetify.com/devbox | bash
fi


# Gems
#gem install git-up lunchy

# Postgres
#cp /usr/local/Cellar/postgresql/9.4.5/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents
#lunchy start postgres
#createuser -s -w postgres

# Memcached
#cp /usr/local/Cellar/memcached/1.4.24/homebrew.mxcl.memcached.plist  ~/Library/LaunchAgents
#lunchy start memcached

# Install neobundle
#curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > neobundle.sh
#sh ./neobundle.sh

# The of the manual stuff documented here:
# https://www.notion.so/realmario/Mac-restore-setup-install-8636630a79184f2b9ac736487e2eafed?pvs=4
