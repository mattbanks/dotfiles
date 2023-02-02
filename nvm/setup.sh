#!/bin/sh
#
# Install nvm and latest lts

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash
nvm install --lts
nvm default 18
