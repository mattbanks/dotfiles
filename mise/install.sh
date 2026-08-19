#!/bin/sh
set -e

MISE_CONFIG_DIR="${XDG_CONFIG_HOME:-$HOME/.config}/mise"
MISE_CONFIG_SOURCE="$DOTFILES/mise/config.toml"
MISE_CONFIG_LINK="$MISE_CONFIG_DIR/conf.d/00-dotfiles.toml"

mkdir -p "$MISE_CONFIG_DIR/conf.d"

if [ -e "$MISE_CONFIG_LINK" ] || [ -L "$MISE_CONFIG_LINK" ]; then
  if [ "$(readlink "$MISE_CONFIG_LINK")" != "$MISE_CONFIG_SOURCE" ]; then
    mv "$MISE_CONFIG_LINK" "$MISE_CONFIG_LINK.backup"
  fi
fi

ln -sfn "$MISE_CONFIG_SOURCE" "$MISE_CONFIG_LINK"

if ! command -v mise >/dev/null 2>&1; then
  echo "mise is not installed; run the Homebrew setup first" >&2
  exit 1
fi

mise install
