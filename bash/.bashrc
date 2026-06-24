# ~/.bashrc

# Only interactive shells
case $- in
  *i*) ;;
  *) return ;;
esac

# History
HISTCONTROL=ignoreboth:erasedups
HISTSIZE=5000
HISTFILESIZE=10000
shopt -s histappend
PROMPT_COMMAND='history -a; history -c; history -r'

# Useful shell behavior
shopt -s checkwinsize
shopt -s globstar 2>/dev/null

# Debian chroot marker
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# Minimal prompt: user@host:path $
PS1='\[\033[0;32m\]\u@\h\[\033[0m\]:\[\033[0;34m\]\w\[\033[0m\]\$ '

# Terminal title
case "$TERM" in
  xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
esac

# lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# bash completion, useful on servers
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Load environment and aliases
[ -f ~/.bash_env ] && . ~/.bash_env
[ -f ~/.bash_aliases ] && . ~/.bash_aliases
export PATH="$HOME/.local/bin:$PATH"

# Dotfiles scripts
_dotfiles_dir="${DOTFILES_DIR:-$HOME/dotfiles}"
_dotfiles_bin="$_dotfiles_dir/scripts/bin"
case ":$PATH:" in
  *":$_dotfiles_bin:"*) ;;
  *) export PATH="$_dotfiles_bin:$PATH" ;;
esac
unset _dotfiles_bin
unset _dotfiles_dir

# Host-local overrides (do not commit secrets here)
[ -f ~/.bashrc.local ] && . ~/.bashrc.local
