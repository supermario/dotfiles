eval "$(rbenv init -)"
eval "$(direnv hook bash)"

if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
  . /etc/bash_completion
fi

function_exists() {
  declare -f -F $1 > /dev/null
  return $?
}

for al in `__git_aliases`; do
  alias g$al="git $al"

  complete_func=_git_$(__git_aliased_command $al)
  function_exists $complete_fnc && __git_complete g$al $complete_func
done

# Run rubocop for all new/modified files
alias rc="git status --short | grep -v -e '^\s*[DR]' | awk '{print \$2}' | grep -e 'rb$' | xargs rubocop"

# Run rspec for all new/modified spec files since origin/master
alias rt="git diff --name-only HEAD origin/master | grep -e 'spec.*\.rb' | xargs rspec"
