#!/bin/sh
if test "$(which code)"; then
	if [ "$(uname -s)" = "Darwin" ]; then
		VSCODE_HOME="$HOME/Library/Application Support/Code"
	else
		VSCODE_HOME="$HOME/.config/Code"
	fi

	ln -sf "$DOTFILES/vscode/settings.json" "$VSCODE_HOME/User"
	ln -sf "$DOTFILES/vscode/keybindings.json" "$VSCODE_HOME/User"
	ln -sf "$DOTFILES/vscode/snippets" "$VSCODE_HOME/User"

	# from `code --list-extensions`
	modules="
EditorConfig.EditorConfig
PKief.material-icon-theme
PeterJausovec.vscode-docker
Zignd.html-css-class-completion
abusaidm.html-snippets
bajdzis.vscode-twig-pack
christian-kohler.npm-intellisense
christian-kohler.path-intellisense
dbaeumer.vscode-eslint
donjayamanne.python
eg2.vscode-npm-script
hollowtree.vue-snippets
jasonnutter.search-node-modules
lukehoban.Go
ms-vscode.atom-keybindings
naumovs.color-highlight
neilding.language-liquid
nemesarial.dust
rebornix.Ruby
samverschueren.linter-xo
timothymclane.react-redux-es6-snippets
tungvn.wordpress-snippet
waderyan.nodejs-extension-pack
xabikos.JavaScriptSnippets
zhuangtongfa.Material-theme
"
	for module in $modules; do
		code --install-extension "$module" || true
	done
fi
