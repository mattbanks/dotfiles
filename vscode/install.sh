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
EditorConfig.EditorConfig
Mikael.Angular-BeastCode
PKief.material-icon-theme
PeterJausovec.vscode-docker
Zignd.html-css-class-completion
abusaidm.html-snippets
bajdzis.vscode-twig-pack
bungcip.better-toml
dbaeumer.vscode-eslint
eg2.tslint
mauve.terraform
mikestead.dotenv
ms-vscode.atom-keybindings
ms-vscode.Go
naumovs.color-highlight
neilding.language-liquid
timothymclane.react-redux-es6-snippets
tungvn.wordpress-snippet
xabikos.JavaScriptSnippets
zhuangtongfa.Material-theme
"
	for module in $modules; do
		code --install-extension "$module" || true
	done
fi
