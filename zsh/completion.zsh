# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# AWS CLI completions from Homebrew
source /usr/local/share/zsh/site-functions/_aws
