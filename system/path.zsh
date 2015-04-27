export PATH="./bin:$HOME/.rbenv/shims:/usr/local/bin:/usr/local/sbin:$HOME/.sfs:$ZSH/bin:$PATH"

export MANPATH="/usr/local/man:/usr/local/mysql/man:/usr/local/git/man:$MANPATH"

# Add Node to PATH
export PATH="$PATH:/usr/local/share/npm/bin"

# Set WP-CLI PHP to MAMP Pro 3 PHP 5.5
export MAMP_PHP="/Applications/MAMP/bin/php/$(ls /Applications/MAMP/bin/php/ | tail -1)/bin"
export PATH="$MAMP_PHP:$PATH"
