#!/bin/bash
# Description: Sets up a new OSX laptop by installing common applications

# Add Color Options
GREEN='\033[0;32m'

echo "Going to modify folders so brew can install properly..."
sudo chown -R $(whoami) $(brew --prefix)/*
echo "${GREEN}Done."

echo "Installing & Updating Homebrew (brew)..."
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
brew tap Homebrew/bundle
brew update
echo "${GREEN}Done."

echo "Install apps via brew and cask"
brew bundle
echo "${GREEN}Done."

echo "Configuring git..."
git config --global push.default upstream
echo "${GREEN}Done."

echo "Configuring bash profile..."
echo "if [ -f $(pwd)/.bash_profile ]; then
    source $(pwd)/.bash_profile
fi

if [ -f $(pwd)/.private.bash_profile ]; then
    source $(pwd)/.private.bash_profile
fi" > ~/.bash_profile
echo "${GREEN}Done."

echo "Creating link to Dropbox on Desktop..."
mkdir -p ~/Dropbox
ln -s ~/Dropbox ~/Desktop
echo "${GREEN}Done."

# TODO: Handle getting/setting up VMs