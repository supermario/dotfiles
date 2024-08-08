# Path to your oh-my-zsh installation.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="min"

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# The optional three formats: "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git heroku)

# User configuration

export PATH="$PATH:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
# export MANPATH="/usr/local/man:$MANPATH"

source $ZSH/oh-my-zsh.sh

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# ssh
# export SSH_KEY_PATH="~/.ssh/dsa_id"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(direnv hook zsh)"

export PATH="$PATH:$HOME/.local/bin" # Stack binaries
export PATH="$PATH:$HOME/.cabal/bin" # Cabal binaries

export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

# export NVM_DIR=~/.nvm
# source $(brew --prefix nvm)/nvm.sh

alias ibrew='arch -x86_64 /usr/local/bin/brew'

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Alias vim to nvim
alias vim='nvim'

# Alias sublime to the simpler to type 'lime'
alias lime='subl'

alias vsc='code-insiders'

# Alias docker-compose to dc
alias dc='docker-compose'

# Extend git plugin with 'gs' as 'gst' is an unecessary letter longer
alias gs='git status'
compdef _git gs=git-status
alias gl='git log --oneline --decorate --color'

# These alias disappeared from git plugin...?
alias gap='git add -p'
alias gdc='git diff --cached'

# Colored word-diff, for differences between long lines, i.e. cdiff <file1> <file2>
alias cdiff='wdiff -w "$(tput bold;tput setaf 1)" -x "$(tput sgr0)" -y "$(tput bold;tput setaf 2)" -z "$(tput sgr0)"'

# Commit where we forked from master
alias gmbm='git merge-base HEAD origin/master'

# Git files changed/added/removed (since fork from master)
alias gfc="git --no-pager diff --name-status \`gmbm\`"

# Git files new/modified only (since fork from master)
alias gfcnm="git diff --diff-filter=AM --name-only \`gmbm\`"

# Hard reset to origin/master
alias grhom='git fetch origin && git reset --hard origin/master && git submodule update --init --recursive'

# Git commit ammend
alias gca='git commit --amend'

# Git checkout patch
alias gcp='git checkout -p'

# Git push all remotes
alias gpa='gr | xargs -L1 git push'

# Hub PR
alias hpr='hub pull-request'

# Show all git TODO/FIXME
alias gt='git grep -EI "TODO|FIXME"'

# delete merged git branches
alias gdm='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

# Search reflog for given input
function glf() { git log --graph --reflog --grep=$1 }

# Search all commits for a string
gitfind() {
  if [ -z "$1" ]; then
    echo "Usage: gitfind \"string\""
    return 1
  fi

  local search_string="$1"

  git log -G"$search_string" --pretty=format:"%h - %an, %ar : %s"
}

## Project aliases (these have project-specific dependencies)

# rails project clean
alias rpc='rake clobber && git clean -fd && git-delete-merged'

# Run rails server
alias rs='rails s -b 0.0.0.0'

# Run rake routes & grep
function rrg() { rake routes | grep $@ }

# Run rubocop for all new/modified files with autocorrect
alias rc="gfcnm | grep -e 'rb$' | grep -v 'schema' | xargs bundle exec rubocop -aD"
alias re="gfcnm | grep -e 'rb$' | grep -v 'schema' | xargs bundle exec reek"

alias rdbm='rake db:migrate'
alias rdbmt='rake db:migrate RAILS_ENV=test'

# Rails tests changed
alias rtc="gfcnm | grep -e 'spec\.rb\|\.feature'"
# Rails tests changed specs only
alias rtcs="rtc | grep 'spec.rb'"

# Run rspec for all new/modified spec files since origin/master
alias rt="rtcs; rspec \`rtcs\`"

# Run all spec/features new/modified since origin/master
alias rta="rtc; rspec \`rtc\`"

# Same as `rta` but fail fast, only failures
alias rtaff="rtc; rspec --fail-fast --only-failures \`rtc\`"

alias rp="rta && rc && re"

# Run elm-reactor
alias er='elm-reactor'

# Set elm binary to 0.18 (installed by npm)
alias e18='cd /Users/mario/.local/bin/ && rm elm && ln -s elm-0.18 elm && cd -'

# Set elm binary to 0.19 alpha
alias e19='cd /Users/mario/.local/bin/ && rm elm && ln -s elm-0.19 elm && cd -'

# Set elm binary to 0.19 alpha
alias ex='cd /Users/mario/.local/bin/ && rm elm && ln -s elmx elm && cd -'

# Set haskell formats. Prior was this;
# hindent --style gibiansky $* | stylish-haskell

# Set haskell-format to brittany
alias hfb='echo "brittany" > /Users/mario/dev/projects/dotfiles/haskell-format'

# Set haskell-format to none
alias hfn='echo "cat" > /Users/mario/dev/projects/dotfiles/haskell-format'

# make build
alias mb="make build"

# List all stack LTS versions in use across top level of projects
alias hlts="tree -L 2 -if ~/dev/projects | grep stack.yaml | xargs grep -E \"^resolver\" -Rn && tree -L 2 -if ~/work | grep stack.yaml | xargs grep -E \"^resolver\" -Rn"

# Stack aliases

alias si="stack install"
alias sg="stack ghci"

# npm shortcuts with --legacy-peer-deps
alias nil='npm i --legacy-peer-deps'

# List processes listening on a given port, i.e. `port 8081`
function port() {
  lsof -n -i4TCP:$@ | grep LISTEN
  lsof -n -iTCP:$@ | grep LISTEN
  lsof -n -i:$@ | grep LISTEN
}

# Fast network switch helpers example

upid="network 1 id"
uppw="network 1 pass"
downid="network 2 id"
downpw="network 2 pass"

# Wifi helpers
alias wu=' $(networksetup -setairportnetwork en0 "$upid" "$uppw") &'
alias wd=' $(networksetup -setairportnetwork en0 "$downid" "$downpw") &'
alias won=' networksetup -setairportpower en0 on &'
alias woff=' networksetup -setairportpower en0 off &'

# System theme
function sd {
  # same command for light and dark mode
  osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'
}
function sl {
  osascript -e 'tell application "System Events" to tell appearance preferences to set dark mode to not dark mode'
}

# Meta

# Edit dotfiles
alias dotfiles='cd ~/dev/projects/dotfiles && vsc .'

# Ping test
alias pt='ping google.com'

# Project helpers

alias lc="cd ~/dev/projects/lamdera-compiler && vsc ."
alias bento="cd ~/dev/projects/bento-life && vsc ."

alias lx="~/lamdera/scripts/lxelm.sh"
alias metro="cd ~/work/locomote/metro && coffee index.coffee"

alias whe="rsync -av --exclude='.git' --exclude='node_modules' ~/work/warehouse ~/work/warehouse-edits && cd ~/work/warehouse-edits"

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

export PATH="/usr/local/opt/libpq/bin:$PATH"
export PATH="$HOME/.cabal/bin:$HOME/.ghcup/bin:$PATH"
export PATH="$(brew --prefix llvm)/bin:$PATH"

[ -f "/Users/mario/.ghcup/env" ] && source "/Users/mario/.ghcup/env" # ghcup-env

export PATH="/opt/homebrew/opt/postgresql@15/bin:$PATH"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
