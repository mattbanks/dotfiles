#!/bin/sh
export PATH="$PATH:$DOTFILES/bin"

# Homebrew python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# All dotfiles scripts, Homebrew installed packages, etc
export PATH="./bin:/usr/local/bin:/usr/local/sbin:$DOTFILES/bin:$HOME/.bin:$PATH"
