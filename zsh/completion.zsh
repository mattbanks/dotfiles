# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# WP-CLI Bash completions
autoload bashcompinit
bashcompinit

# WP-CLI Bash completions from Homebrew
if [ -f $(brew --prefix)/etc/bash_completion.d/wp-completion.bash ]; then
	. $(brew --prefix)/etc/bash_completion.d/wp-completion.bash
fi
