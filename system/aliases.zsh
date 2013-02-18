# grc overides for ls
#   Made possible through contributions from generous benefactors like
#   `brew install coreutils`
# if $(gls &>/dev/null)
# then
#   alias ls="gls -F --color"
#   alias l="gls -lAh --color"
#   alias ll="gls -l --color"
#   alias la='gls -A --color'
# fi

# Move or rename multiple files with wildcards and such
# Thanks go to http://www.mfasold.net/blog/2008/11/moving-or-renaming-multiple-files/
autoload -U zmv
alias mmv='noglob zmv -W'

# Easier navigation: .., ..., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ~="cd ~"
alias -- -="cd -"

# List dir contents aliases
# ref: http://ss64.com/osx/ls.html
# Long form no user group, color
alias l="ls -oG"
# Order by last modified, long form no user group, color
alias lt="ls -toG"
# List all except . and ..., color, mark file types, long form no user group, file size
alias la="ls -AGFoh"
# List all except . and ..., color, mark file types, long form no use group, order by last modified, file size
alias lat="ls -AGFoth"
# List only directories
alias lsd='ls -l | grep "^d"'
# List only files
alias lsf='ls -l | grep -v "^d"'

# Concatenate and print content of files (add line numbers)
alias catn="cat -n"

# IP addresses
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ifconfig -a | grep -o 'inet \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | grep -v '127\.0\.0\.1' | sed -e 's/inet //'"
alias ips="ifconfig -a | grep -o 'inet6\? \(\([0-9]\+\.[0-9]\+\.[0-9]\+\.[0-9]\+\)\|[a-fA-F0-9:]\+\)' | sed -e 's/inet6* //'"

# Enhanced WHOIS lookups
alias whois="whois -h whois-servers.net"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# View HTTP traffic
alias sniff="sudo ngrep -d 'en1' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i en1 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""

# OS X has no `sha1sum`, so use `shasum` as a fallback
command -v sha1sum > /dev/null || alias sha1sum="shasum"

# Trim new lines and copy to clipboard
alias c="tr -d '\n' | pbcopy"

# Recursively delete `.DS_Store` files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Shortcuts
alias d="cd ~/Dropbox"
alias df="cd ~/.dotfiles"
alias p="cd ~/Dropbox/Projects"
alias dl="cd ~/Downloads"
alias s="cd ~/Sites"
alias st="subl"
alias stt="subl ."
alias t="tar -pcvzf"
alias tx="tar -pvxf"
alias g="git"
alias v="vim"
alias o="open"
alias oo="open ."

# Enable aliases to be sudo’ed
alias sudo='sudo '

# Homebrew, NPM, RVM, Gems Update, Cleanup Brew and Gems
alias pkgup="brew update; brew upgrade; npm update -g; rvm get stable; gem update --system; gem update;"
alias pkgclean="brew cleanup; npm cache clean; gem cleanup;"

# Edit hosts file and vhosts config for local development
alias edithost="sudo st /private/etc/hosts"
alias editvhosts="sudo st /private/etc/apache2/extra/httpd-vhosts.conf"

# Local Servers (Apache and MySQL)
alias sstart="sudo apachectl start; mysql.server start"
alias sstop="sudo apachectl stop; mysql.server stop"
alias srestart="sudo apachectl restart; mysql.server restart"

# File size
alias fs="stat -c \"%s bytes\""

# ROT13-encode text. Works for decoding, too! ;)
alias rot13='tr a-zA-Z n-za-mN-ZA-M'
