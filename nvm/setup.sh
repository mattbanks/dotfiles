#!/bin/sh
#
# Install nvm and latest lts

curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
nvm install --lts
nvm alias default 'lts/*'
