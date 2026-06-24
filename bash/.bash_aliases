# ~/.bash_aliases

# ls
alias ls='ls --color=auto'
alias ll='ls -lah'
alias la='ls -A'
alias l='ls -CF'

# grep
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
