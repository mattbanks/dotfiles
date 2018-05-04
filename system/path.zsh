#!/bin/sh
export PATH="$PATH:$DOTFILES/bin:$HOME/.bin"

# Homebrew python
export PATH="/usr/local/opt/python/libexec/bin:$PATH"

# Homebrew Node 8, because Node 10 breaks everything right now
export PATH="/usr/local/opt/node@8/bin:$PATH"

# All dotfiles scripts, Homebrew installed packages, etc
export PATH="./bin:/usr/local/bin:/usr/local/sbin:$DOTFILES/bin:$HOME/.bin:$PATH"
