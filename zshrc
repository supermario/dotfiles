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
plugins=(git)

# User configuration

export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
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

export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

# Alias sublime to the simpler to type 'lime'
alias lime='subl'

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
alias grhom='git fetch origin && git reset --hard origin/master'

# Git checkout patch
alias gcp='git checkout -p'

# Git push all remotes
alias gpa='gr | xargs -L1 git push'

# Hub PR
alias hpr='hub pull-request'

# delete merged git branches
alias gdm='git branch --merged | grep -v "\*" | xargs -n 1 git branch -d'

## Project aliases (these have project-specific dependencies)

# rails project clean
alias rpc='rake clobber && git clean -fd && git-delete-merged'

# Run rails server
alias rs='rails s -b 0.0.0.0'

# Run rake routes & grep
function rrg() { rake routes | grep $@ }

# Run rubocop for all new/modified files with autocorrect
alias rc="gfcnm | grep -e 'rb$' | grep -v 'schema' | xargs bundle exec rubocop --rails -aD"

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
