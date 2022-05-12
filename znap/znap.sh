#!/bin/sh

# Download Znap, if it's not there yet.
[[ -f ~/Code/znap/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Code/znap/zsh-snap

source ~/Code/znap/zsh-snap/znap.zsh  # Start Znap

# this block is in alphabetic order
znap source mafredri/zsh-async
znap source rupa/z
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source lukechilds/zsh-nvm

# these should be at last!
znap source sindresorhus/pure
znap source zdharma/fast-syntax-highlighting
znap source zsh-users/zsh-history-substring-search
