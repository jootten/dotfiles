gh auth login
git clone --separate-git-dir=$HOME/.dotfiles https://github.com/jootten/dotfiles.git $HOME/mydotfiles
rm -r $HOME/mydotfiles
alias config='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
config checkout -- .
config checkout vlab-vm
wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
sh install.sh --keep-zshrc --unattended
rm install.sh
conda create -n benchmark python=3.8 virtualenv
sudo chsh -s /bin/zsh $USER
/opt/conda/bin/python -m pip install pynvim
sudo apt install ripgrep
