#!/bin/sh
# modern make
if which mmake >/dev/null 2>&2; then
	alias make='mmake'
fi

# exa is a better ls tool
if which exa >/dev/null 2>&1; then
	alias ls='exa'
	alias l='exa -lah --git'
	alias la='exa -laah --git'
	alias ll='exa -lh --git'
	alias lt='exa -lhT'
else
	if [ "$(uname -s)" = "Darwin" ]; then
		alias ls="ls -FG"
	else
		alias ls="ls -F --color"
	fi
	alias l="ls -lAh"
	alias la="ls -A"
	alias ll="ls -l"
fi

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias -- -="cd -"

alias grep="grep --color=auto"
alias duf="du -sh * | sort -hr"
alias less="less -r"

# quick hack to make watch work with aliases
alias watch='watch -c -d -t '

# open, pbcopy and pbpaste on linux
if [ "$(uname -s)" != "Darwin" ]; then
	if [ -z "$(command -v pbcopy)" ]; then
		if [ -n "$(command -v xclip)" ]; then
			alias pbcopy="xclip -selection clipboard"
			alias pbpaste="xclip -selection clipboard -o"
		elif [ -n "$(command -v xsel)" ]; then
			alias pbcopy="xsel --clipboard --input"
			alias pbpaste="xsel --clipboard --output"
		fi
	fi
	if [ -e /usr/bin/xdg-open ]; then
		alias open="xdg-open"
	fi
fi

# Shortcuts
alias df="cd ~/.dotfiles"
alias dl="cd ~/Downloads"
alias t="tar -pcvzf"
alias tx="tar -pvxf"
alias oo="open ."
