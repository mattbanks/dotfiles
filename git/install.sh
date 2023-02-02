#!/bin/sh

# Don't ask ssh password all the time
if [ "$(uname -s)" = "Darwin" ]; then
	git config --global credential.helper osxkeychain
else
	git config --global credential.helper cache
fi

# better diffs
# if command -v diff-so-fancy >/dev/null 2>&1; then
# 	git config --global core.pager "diff-so-fancy | less --tabs=4 -RFX"
# fi

# use vscode as mergetool
# if command -v code >/dev/null 2>&1; then
# 	git config --global merge.tool vscode
# 	git config --global mergetool.vscode.cmd "code --wait $MERGED"
# fi
