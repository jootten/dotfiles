# Dotfiles
These are my personal dotfiles. Work is still in progress. Use only as inspiration. :grin:

## Highlights
* Fully fledged Neovim configuration with many useful plugins, keybindings and autocompletion. Optimized for Python development.
* Low-level XKeymap that allows to fully utilize ijkl as arrow keys and uo as home/end when holding caps lock (only in US layout).

## Setup

Set `config` git alias once, persisted later on in `.zshrc`.
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

1. LSP capabilities require node. To install you can use `nvm`.

### ZSH

Install [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh)
```
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
mv .zshrc.pre-oh-my-zsh .zshrc
```
