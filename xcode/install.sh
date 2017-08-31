#!/bin/sh
XCODE_HOME="$HOME/Library/Developer/Xcode/UserData/FontAndColorThemes"

if test ! -d "$XCODE_HOME"; then
	mkdir $XCODE_HOME
fi

ln -sf "$DOTFILES/xcode/Jones.dvtcolortheme.json" "$XCODE_HOME/Jones.dvtcolortheme.json"
