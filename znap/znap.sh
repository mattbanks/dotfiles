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
# TODO - re-enable lazy loading when znap fixes the bug that it has
# https://github.com/marlonrichert/zsh-snap/discussions/174#109
# znap source lukechilds/zsh-nvm

# these should be at last!
znap source sindresorhus/pure
znap source zdharma/fast-syntax-highlighting
znap source zsh-users/zsh-history-substring-search

# TODO - possibly remove this when znap fixes the bug that it has
# https://github.com/marlonrichert/zsh-snap/discussions/174#109
# Lazy load NVM and Node with znap
sourcenvm='source $NVM_DIR/nvm.sh && source $NVM_DIR/bash_completion'
znap function nvm $sourcenvm
znap function node $sourcenvm
znap function npm $sourcenvm
znap function npx $sourcenvm
