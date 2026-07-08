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

export NIX_SSL_CERT_FILE=/etc/pki/ca-trust/extracted/pem/tls-ca-bundle.pem
if [ -e $HOME/.nix-profile/etc/profile.d/nix.sh ]; then . $HOME/.nix-profile/etc/profile.d/nix.sh; fi

if [ -f ".envrc" ]; then direnv reload; fi

if command -v zoxide > /dev/null 2>&1; then
  eval "$(zoxide init zsh)"
fi

# gcloud
if [ -f "/lib64/google-cloud-sdk/path.zsh.inc"  ]; then . "/lib64/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "/lib64/google-cloud-sdk/completion.zsh.inc" ]; then . "/lib64/google-cloud-sdk/completion.zsh.inc"; fi

if [ -f "$HOME/.nix-profile/share/zsh/site-functions/_gcloud" ]; then . "$HOME/.nix-profile/share/zsh/site-functions/_gcloud"; fi

# mise
if [ -x "$HOME/.local/bin/mise" ]; then
  eval "$("$HOME/.local/bin/mise" activate zsh)"
fi

# pnpm
if [ "$(uname)" = "Darwin" ]; then
  export PNPM_HOME="$HOME/Library/pnpm"
  pnpm_bin="$PNPM_HOME/bin"
else
  export PNPM_HOME="$HOME/.local/share/pnpm"
  pnpm_bin="$PNPM_HOME"
fi
case ":$PATH:" in
  *":$pnpm_bin:"*) ;;
  *) export PATH="$pnpm_bin:$PATH" ;;
esac
unset pnpm_bin
# === End tools configuration ===
