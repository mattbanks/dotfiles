# Reset Sound... useful when Mountain Lion won't let you select an AirPlay output
alias resetsound="sudo kill `ps -ax | grep 'coreaudiod' | grep 'sbin' | awk '{print $1}'`"

# Reset Events... useful when Mountain Lion hangs when attempting to unzip something
alias resetevents="sudo killall -KILL appleeventsd"

# Empty the Trash on all mounted volumes and the main HDD
alias emptytrash="sudo rm -rfv /Volumes/*/.Trashes; rm -rfv ~/.Trash"

# Show/hide hidden files in Finder
alias show="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
alias hide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"


# Disable Gatekeeper
alias gateoff="sudo spctl --master-disable"
# Enable Gatekeeper
alias gateon="sudo spctl --master-enable"

# Disable Spotlight
alias spotoff="sudo mdutil -a -i off"
# Enable Spotlight
alias spoton="sudo mdutil -a -i on"

# PlistBuddy alias, because sometimes `defaults` just doesn’t cut it
alias plistbuddy="/usr/libexec/PlistBuddy"

# Get OS X Software Updates, update Homebrew itself, and upgrade installed Homebrew packages
alias update='sudo softwareupdate -i -a; brew update; brew upgrade'

# Start Screen Saver
alias ss='open /System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app'

# Merge PDF files
# Usage: `mergepdf -o output.pdf input{1,2,3}.pdf`
alias mergepdf='/System/Library/Automator/Combine\ PDF\ Pages.action/Contents/Resources/join.py'

# Disable Dashboard
alias dashboardoff="defaults write com.apple.dashboard mcx-disabled -boolean YES && killall Dock"
# Enable Dashboard
alias dashboardon="defaults write com.apple.dashboard mcx-disabled -boolean NO && killall Dock"
