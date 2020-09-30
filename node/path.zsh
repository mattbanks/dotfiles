#!/bin/sh
export PATH="$PATH:$HOME/.npm/bin"

# NVM, if installed
export NVM_LAZY_LOAD=true
export NVM_COMPLETION=false

#### LEAVING THIS OLD WAY FOR REFERENCE LATER IN A COMMIT

# # Load NVM
# export NVM_DIR="$HOME/.nvm"

# # Add default Node to path (latest installed)
# export PATH=$HOME/.nvm/versions/node/$(ls $NVM_DIR/versions/node | sort -V | tail -n1)/bin:$PATH

# # Source the NVM scripe with --no-use to speed it up
# [[ -s "$NVM_DIR/nvm.sh" ]] && source "$NVM_DIR/nvm.sh" --no-use

# # Source the NVM bash completion
# # [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
