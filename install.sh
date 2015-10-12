#!/bin/sh
set -e

DOTFILES=`pwd`

link() {
  # Force create/replace the symlink
  ln -fs "${1}" "${HOME}/${2}"
  echo "${1} -> ${2}"
}

# This runs zsh when done... need to figure out how to prevent that
sh -c "$(curl -fsSL https://raw.github.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

link "${DOTFILES}/zshrc"     ".zshrc"
link "${DOTFILES}/vimrc"     ".vimrc"
link "${DOTFILES}/gitconfig" ".gitconfig"
link "${DOTFILES}/tmux.conf" ".tmux.conf"

link "${HOME}/Dropbox/dev"   "dev"

link "${DOTFILES}/min.zsh-theme"   ".oh-my-zsh/themes/min.zsh-theme"

SOLARIZED="${DOTFILES}/solarized"
if [[ ! -d ${SOLARIZED} ]]; then
  # Install solarized theme
  git clone git://github.com/altercation/solarized.git $SOLARIZED
fi

SOLARIZED_VIM="${HOME}/.vim/colors/solarized.vim"
if [[ ! -f ${SOLARIZED_VIM} ]]; then
  mkdir -p "${HOME}/.vim/colors"
  mv "${SOLARIZED}/vim-colors-solarized/colors/solarized.vim" $SOLARIZED_VIM
fi

# Gems
gem install git-up lunchy

# Postgres
cp /usr/local/Cellar/postgresql/9.4.4/homebrew.mxcl.postgresql.plist ~/Library/LaunchAgents
lunchy start postgres
createuser -s -w postgres

# Memcached
cp /usr/local/Cellar/memcached/1.4.24/homebrew.mxcl.memcached.plist  ~/Library/LaunchAgents
lunchy start postgres

# Install neobundle
curl https://raw.githubusercontent.com/Shougo/neobundle.vim/master/bin/install.sh > neobundle.sh
sh ./neobundle.sh
