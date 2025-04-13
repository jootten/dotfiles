# === Begin Oh My Zsh configuration ===
export ZSH="$HOME/.oh-my-zsh"  # path to omz installation

ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git docker vi-mode)

source $ZSH/oh-my-zsh.sh
# === End Oh My Zsh configuration ===


# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'


# === Begin tools configuration ===
eval "$(direnv hook zsh)"
if [ -f ".envrc" ]; then direnv reload; fi

eval "$(zoxide init zsh)"

# gcloud
if [ -f "/lib64/google-cloud-sdk/path.zsh.inc"  ]; then . "/lib64/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "/lib64/google-cloud-sdk/completion.zsh.inc" ]; then . "/lib64/google-cloud-sdk/completion.zsh.inc"; fi

# pnpm
export PNPM_HOME="/home/jonas/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
if [ -f "~/.completion-for-pnpm.zsh" ]; then . "~/.completion-for-pnpm.zsh"; fi
# === End tools configuration ===
