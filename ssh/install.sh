#!/bin/sh
set -e

SSH_DIR="$HOME/.ssh"
SSH_CONFIG="$SSH_DIR/config"
SSH_CONFIG_LOCAL="$SSH_DIR/config.local"
SSH_CONFIG_SOURCE="$DOTFILES/ssh/config"

mkdir -p "$SSH_DIR"
chmod 700 "$SSH_DIR"

if [ ! -e "$SSH_CONFIG_LOCAL" ] && [ ! -L "$SSH_CONFIG_LOCAL" ]; then
	if [ -L "$SSH_CONFIG" ] && [ "$(readlink "$SSH_CONFIG")" = "$SSH_CONFIG_SOURCE" ]; then
		touch "$SSH_CONFIG_LOCAL"
	elif [ -e "$SSH_CONFIG" ] || [ -L "$SSH_CONFIG" ]; then
		mv "$SSH_CONFIG" "$SSH_CONFIG_LOCAL"
	else
		touch "$SSH_CONFIG_LOCAL"
	fi
fi

if [ ! -L "$SSH_CONFIG" ] || [ "$(readlink "$SSH_CONFIG")" != "$SSH_CONFIG_SOURCE" ]; then
	if [ -e "$SSH_CONFIG" ] || [ -L "$SSH_CONFIG" ]; then
		SSH_CONFIG_BACKUP="$SSH_DIR/config.backup.$(date +%Y%m%d%H%M%S).$$"
		mv "$SSH_CONFIG" "$SSH_CONFIG_BACKUP"
	fi
	ln -s "$SSH_CONFIG_SOURCE" "$SSH_CONFIG"
fi
