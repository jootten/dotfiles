gh auth login
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/jootten/dotfiles.git $HOME/mydotfiles
rm -r $HOME/mydotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh --keep-zshrc --unattended
rm install.sh
sudo chsh -s /bin/zsh $USER
pip install pynvim
sudo apt install ripgrep
