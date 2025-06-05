#!/bin/sh

# Download Znap, if it's not there yet.
[[ -f ~/Developer/znap/zsh-snap/znap.zsh ]] ||
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git ~/Developer/znap/zsh-snap

source ~/Developer/znap/zsh-snap/znap.zsh  # Start Znap

# Only load Pure prompt outside of Warp
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  # set the prompt
  znap prompt sindresorhus/pure
fi

# setup plugins
znap source rupa/z
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-history-substring-search
znap source zsh-users/zsh-syntax-highlighting
znap source lukechilds/zsh-nvm
znap source davidparsson/zsh-pyenv-lazy

# Note - leaving here in case need to re-enable at a later date
#
# Lazy load NVM and Node with znap
# We need to make sure we lazy load NVM in for global NPM packages too. This is messy.
# sourcenvm='source $NVM_DIR/nvm.sh && source $NVM_DIR/bash_completion'
# znap function nvm $sourcenvm
# znap function node $sourcenvm
# znap function npm $sourcenvm
# znap function npx $sourcenvm
# znap function ncu $sourcenvm
