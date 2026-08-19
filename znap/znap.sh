#!/bin/zsh

# Download Znap into user data, if it's not there yet.
ZNAP_REPO="${XDG_DATA_HOME:-$HOME/.local/share}/znap/zsh-snap"
if [[ ! -f "$ZNAP_REPO/znap.zsh" ]]; then
    mkdir -p "${ZNAP_REPO:h}" || return 1
    git clone --depth 1 -- \
        https://github.com/marlonrichert/zsh-snap.git "$ZNAP_REPO" || return 1
fi

source "$ZNAP_REPO/znap.zsh" || return 1  # Start Znap

# Pure prompt (disabled in favour of Starship — uncomment to roll back)
# if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
#   znap prompt sindresorhus/pure
# fi

# setup plugins
znap source agkozak/zsh-z
znap source zsh-users/zsh-completions
znap source zsh-users/zsh-autosuggestions
znap source zsh-users/zsh-history-substring-search
znap source zsh-users/zsh-syntax-highlighting

unset ZNAP_REPO
