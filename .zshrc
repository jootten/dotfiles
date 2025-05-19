# === Begin Oh My Zsh configuration ===
export ZSH="$HOME/.oh-my-zsh"  # path to omz installation

ZSH_THEME="robbyrussell"
COMPLETION_WAITING_DOTS="true"

# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
plugins=(git docker vi-mode)

if [ -f "$ZSH/oh-my-zsh.sh" ]; then
  . $ZSH/oh-my-zsh.sh
fi
# === End Oh My Zsh configuration ===


# Preferred editor for local and remote sessions
export EDITOR='nvim'

# Aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
alias vi=nvim
alias tm=tmux
alias lg=lazygit
alias lg-dotfiles="lazygit -g $HOME/.dotfiles -w $HOME"

# === Begin tools configuration ===
if command -v direnv > /dev/null 2>&1; then
  eval "$(direnv hook zsh)"
fi

if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

if [ -f ".envrc" ]; then direnv reload; fi

if command -v zoxide > /dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# gcloud
if [ -f "/lib64/google-cloud-sdk/path.zsh.inc"  ]; then . "/lib64/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "/lib64/google-cloud-sdk/completion.zsh.inc" ]; then . "/lib64/google-cloud-sdk/completion.zsh.inc"; fi

if [ -f "$HOME/.nix-profile/share/zsh/site-functions/_gcloud" ]; then . "$HOME/.nix-profile/share/zsh/site-functions/_gcloud"; fi

if [ -f "$HOME/.nix-profile/share/zsh/site-functions/_uv" ]; then . "$HOME/.nix-profile/share/zsh/site-functions/_uv"; fi

# pnpm
export PNPM_HOME="/home/jonas/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
if [ -f "~/.completion-for-pnpm.zsh" ]; then . "~/.completion-for-pnpm.zsh"; fi
# === End tools configuration ===
