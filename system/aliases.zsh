#!/bin/sh
# modern make
if which mmake >/dev/null 2>&2; then
	alias make='mmake'
fi

# eza is a better ls tool
if which eza >/dev/null 2>&1; then
	alias ls='eza'
	alias l='eza -lah --git'
	alias la='eza -laah --git'
	alias ll='eza -lh --git'
	alias lt='eza -lhT'
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

# Tailscale
alias tailscale='/Applications/Tailscale.app/Contents/MacOS/Tailscale'
