export SDL_VIDEODRIVER=wayland
export QT_QPA_PLATFORM=wayland

export PATH="$HOME/.local/bin:$PATH"  # Override system installed globals
export PATH=$PATH:$HOME/bin
if [ -d $HOME/go/bin ]; then export PATH=$PATH:$HOME/go/bin; fi
