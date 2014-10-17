# matches case insensitive for lowercase
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'

# pasting with tabs doesn't perform completion
zstyle ':completion:*' insert-tab pending

# Load Bash completions
autoload bashcompinit
bashcompinit

# WP-CLI Bash completions from Homebrew
if [ -f ~/.dotfiles/wp-cli/wp-completion.bash ]; then
	. ~/.dotfiles/wp-cli/wp-completion.bash
fi

# NPM Bash completions from Homebrew
if [ -f $(brew --prefix)/etc/bash_completion.d/npm ]; then
	. $(brew --prefix)/etc/bash_completion.d/npm
fi
