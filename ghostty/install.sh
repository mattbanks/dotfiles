#!/bin/sh
mkdir -p "$HOME/.config/ghostty"
test -L "$HOME/.config/ghostty/config" || ln -sf "$DOTFILES/ghostty/config" "$HOME/.config/ghostty/config"
