# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# WP-CLI Bash completions
autoload bashcompinit
bashcompinit
source $HOME/.wp-cli/vendor/wp-cli/wp-cli/utils/wp-completion.bash
