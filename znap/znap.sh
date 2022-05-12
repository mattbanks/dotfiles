#!/bin/sh

# Download Znap, if it's not there yet.
[[ -f ~/Code/znap/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Code/znap/zsh-snap

source ~/Code/znap/zsh-snap/znap.zsh  # Start Znap

# set the prompt
znap prompt sindresorhus/pure

# setup plugins
znap source rupa/z
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-history-substring-search
znap source zsh-users/zsh-syntax-highlighting

# Lazy load NVM and Node with znap
sourcenvm='source $NVM_DIR/nvm.sh && source $NVM_DIR/bash_completion'
znap function nvm $sourcenvm
znap function node $sourcenvm
znap function npm $sourcenvm
znap function npx $sourcenvm
