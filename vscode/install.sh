#!/bin/sh
if command -v code >/dev/null; then
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
aaron-bond.better-comments
bungcip.better-toml
christian-kohler.npm-intellisense
christian-kohler.path-intellisense
CoenraadS.bracket-pair-colorizer
dbaeumer.vscode-eslint
dsznajder.es7-react-js-snippets
eamodio.gitlens
EditorConfig.EditorConfig
esbenp.prettier-vscode
felixfbecker.php-debug
formulahendry.auto-close-tag
formulahendry.auto-rename-tag
mikestead.dotenv
mrmlnc.vscode-scss
ms-vscode.atom-keybindings
ms-vscode.Go
ms-vscode.vscode-typescript-tslint-plugin
msjsdiag.debugger-for-chrome
naumovs.color-highlight
octref.vetur
Orta.vscode-jest
PeterJausovec.vscode-docker
PKief.material-icon-theme
quicktype.quicktype
shinnn.stylelint
streetsidesoftware.code-spell-checker
tungvn.wordpress-snippet
wix.vscode-import-cost
xabikos.JavaScriptSnippets
zhuangtongfa.Material-theme
Zignd.html-css-class-completion
"
	for module in $modules; do
		code --install-extension "$module" || true
	done
fi
