#!/bin/sh
if test "$(which code)"; then
	if [ "$(uname -s)" = "Darwin" ]; then
		VSCODE_HOME="$HOME/Library/Application Support/Code"
	else
		VSCODE_HOME="$HOME/.config/Code"
	fi

	ln -sf "$DOTFILES/vscode/settings.json" "$VSCODE_HOME/User/settings.json"
	ln -sf "$DOTFILES/vscode/keybindings.json" "$VSCODE_HOME/User/keybindings.json"
	ln -sf "$DOTFILES/vscode/snippets" "$VSCODE_HOME/User/snippets"

	# from `code --list-extensions`
	modules="
2gua.rainbow-brackets
EditorConfig.EditorConfig
Zignd.html-css-class-completion
aaron-bond.better-comments
abusaidm.html-snippets
bajdzis.vscode-twig-pack
bungcip.better-toml
CoenraadS.bracket-pair-colorizer
dbaeumer.vscode-eslint
dsznajder.es7-react-js-snippets
eg2.tslint
mauve.terraform
Mikael.Angular-BeastCode
mikestead.dotenv
mrmlnc.vscode-scss
ms-vscode.atom-keybindings
ms-vscode.Go
ms-vsliveshare.vsliveshare
msjsdiag.debugger-for-chrome
naumovs.color-highlight
neilding.language-liquid
PeterJausovec.vscode-docker
PKief.material-icon-theme
seveseves.ngx-translate-zombies
streetsidesoftware.code-spell-checker
timothymclane.react-redux-es6-snippets
tungvn.wordpress-snippet
wix.vscode-import-cost
xabikos.JavaScriptSnippets
zhuangtongfa.Material-theme
"
	for module in $modules; do
		code --install-extension "$module" || true
	done
fi
