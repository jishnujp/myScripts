# ~/.zshrc
# zsh baseline mirroring bash/.bashrc. macOS defaults to zsh; Linux uses bash.

# History
HISTFILE=~/.zsh_history
HISTSIZE=5000
SAVEHIST=10000
setopt SHARE_HISTORY HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE APPEND_HISTORY

# Useful shell behavior
setopt AUTO_CD          # `cd` by typing a directory name
setopt EXTENDED_GLOB
setopt NO_BEEP

# Minimal prompt: user@host:path %  (green user@host, blue path)
setopt PROMPT_SUBST
PROMPT='%F{green}%n@%m%f:%F{blue}%~%f%# '

# Completion
autoload -Uz compinit && compinit

# Load environment and shared (shell-agnostic) aliases
[ -f ~/.zsh_env ] && . ~/.zsh_env
[ -f ~/.shell_common.sh ] && . ~/.shell_common.sh
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
[ -f ~/.zshrc.local ] && . ~/.zshrc.local
