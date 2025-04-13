# Dotfiles
These are my personal dotfiles.

## Stack
* NeoVim: Editor, this repo contains extensive configuration optimized for Python development
* Sway: Window manager based on Wayland
* Oh My Zsh: Extends zsh with plugins etc.
* Tmux: Terminal multiplexer
* direnv: Manage environments based on current direcectory
* foot: Terminal emulator

## Setup

Set `dotfiles` git alias once, persisted later on in `.zshrc`.
```
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
```

Clone repo in temporary dir, restore files in home direcectory.
*Beware*: This ovewrites existing files.
```
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/jootten/dotfiles $HOME/.dotfiles
rm -r tmp
config restore .
```

### Neovim

1. LSP capabilities require node and python. You can use `pnpm` and `uv` for the installation.

### ZSH

Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv .zshrc.pre-oh-my-zsh .zshrc
```
