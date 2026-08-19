#!/bin/sh
#
# Homebrew
#
# This installs some of the common dependencies needed (or at least desired)
# using Homebrew.
set -e

cd "$(dirname "$0")/.."
DOTFILES_ROOT=$(pwd -P)

# Check for Homebrew
if ! command -v brew >/dev/null 2>&1; then
  echo "› Installing Homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

# Homebrew is not added to the current process PATH by a fresh install.
if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

echo "› Installing packages from Brewfile"
brew bundle --file="$DOTFILES_ROOT/Brewfile"

exit 0
