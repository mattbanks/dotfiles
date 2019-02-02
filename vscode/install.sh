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
aaron-bond.better-comments
bajdzis.vscode-twig-pack
ban.spellright
CoenraadS.bracket-pair-colorizer
dbaeumer.vscode-eslint
dsznajder.es7-react-js-snippets
eamodio.gitlens
EditorConfig.EditorConfig
eg2.tslint
esbenp.prettier-vscode
felixfbecker.php-debug
johnpapa.Angular2
Mikael.Angular-BeastCode
mikestead.dotenv
mrmlnc.vscode-scss
ms-vscode.atom-keybindings
ms-vscode.Go
msjsdiag.debugger-for-chrome
naumovs.color-highlight
neilding.language-liquid
PeterJausovec.vscode-docker
PKief.material-icon-theme
quicktype.quicktype
seveseves.ngx-translate-zombies
Shan.code-settings-sync
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
