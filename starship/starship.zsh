#!/bin/zsh
# Initialize Starship prompt (not in Warp, which manages its own prompt)
if [[ $TERM_PROGRAM != "WarpTerminal" ]]; then
  eval "$(starship init zsh)"
fi
