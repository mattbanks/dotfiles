#!/bin/sh
mkdir -p "$HOME/.config"
test -L "$HOME/.config/starship.toml" || ln -sf "$DOTFILES/starship/starship.toml" "$HOME/.config/starship.toml"
