# ~/.shell_common.sh
# Shell-agnostic aliases and environment, sourced by both bash and zsh.
# Keep everything here POSIX-ish so it works under both shells.

# ls: GNU ls supports --color=auto; BSD/macOS ls uses -G + CLICOLOR.
if ls --color=auto >/dev/null 2>&1; then
  alias ls='ls --color=auto'
else
  alias ls='ls -G'
  export CLICOLOR=1
fi
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# grep (GNU); harmless if unsupported since it only affects grep invocations
alias grep='grep --color=auto'

# navigation
alias ..='cd ..'
alias ...='cd ../..'

# basics
alias c='clear'
alias h='history'

# git
alias gs='git status'
alias gd='git diff'
alias gl='git log --oneline --graph --decorate -20'
alias gp='git pull'

# safer file ops
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'
