#!/bin/sh
alias gl='git pull --prune'
alias glg="git log --graph --decorate --oneline --abbrev-commit"
alias glga="glg --all"
alias gp='git push origin HEAD'
alias gpa='git push origin --all'
alias gd='git diff'
alias gc='git commit -s'
alias gca='git commit -s -a'
alias gco='git checkout'
alias gb='git branch -v'
alias ga='git add'
alias gaa='git add -A'
alias gcm='git commit -s -m'
alias gcam='git commit -s -a -m'
alias gs='git status -sb'
alias gpr='gp && git pr'

gi() {
	curl -s "https://www.gitignore.io/api/$*"
}
