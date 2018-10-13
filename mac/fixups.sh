#!/bin/sh

# Disable captivate portal
sudo defaults write /Library/Preferences/SystemConfiguration/com.apple.captive.control Active -bool false

# Disable crash reporter
defaults write com.apple.CrashReporter DialogType none

# Use plain text mode in TextEdit
defaults write com.apple.TextEdit RichText -int 0

# Disable doc bouncing
defaults write com.apple.dock no-bouncing -bool false && killall Dock

defaults write -g NSNavPanelExpandedStateForSaveMode -bool true && \
    defaults write -g NSNavPanelExpandedStateForSaveMode2 -bool true

# Show finder status bar
defaults write com.apple.finder ShowPathbar -bool true

# Show finder status bar
defaults write com.apple.finder ShowStatusBar -bool true

# Disable saving to Cloud by default
defaults write -g NSDocumentSaveNewDocumentsToCloud -bool false

defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true

# Disable autocorrect
defaults write -g NSAutomaticSpellingCorrectionEnabled -bool false

defaults write com.apple.QuickTimePlayerX MGPlayMovieOnOpen 1

# Show Library folder
chflags nohidden ~/Library
