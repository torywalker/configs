#!/bin/bash
# Description: Sets up a new macOS instance by installing common applications and configurations

# Add Color Options
GREEN='\033[0;32m'

echo -n "Do you wish to install brew (y/n)?"
read brew_answer

if [ "$brew_answer" != "${brew_answer#[Yy]}" ] ;then
    echo "Going to modify folders so brew can install properly..."
    sudo chown -R $(whoami) $(brew --prefix)/*
    echo "${GREEN}Done."

    echo "Installing & Updating Homebrew (brew)..."
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
    brew tap Homebrew/bundle
    brew update
    echo "${GREEN}Done."
else
    echo "Skipping installation of brew"
fi

echo -n "Do you wish to install default brew applications (y/n)?"
read app_answer

if [ "$app_answer" != "${app_answer#[Yy]}" ] ;then
    echo "Installing apps via brew and cask..."
    brew bundle
    echo "${GREEN}Done."
else
    echo "Skipping installation of default brew applications"
fi

echo -n "Do you wish to configure git (y/n)?"
read git_answer

if [ "$git_answer" != "${git_answer#[Yy]}" ] ;then
    echo "Configuring git..."
    git config --global push.default upstream
    echo "${GREEN}Done."
else
    echo "Skipping configuration of git"
fi

echo -n "Do you wish to configure your profile (y/n)?"
read profile_answer

if [ "$profile_answer" != "${profile_answer#[Yy]}" ] ;then
    echo -n "What is the filename of your main profile? (e.g. .bash_profile, .profile)"
    read which_profile

    #TODO: If which_profile is blank, exit from this if statemnt
    echo "Copying base profile file..."
    cp ./.bash_profile ~/.bash_profile_base

    echo "Configuring main profile..."
    echo "if [ -f $(pwd)/.bash_profile_base ]; then
        source $(pwd)/.bash_profile_base
    fi" > ~/"$which_profile"
    echo "${GREEN}Done."
else
    echo "Skipping profile configuration!"
fi

echo -n "Do you wish to add an alias to Dropbox on your Desktop (y/n)?"
read dropbox_answer

if [ "$dropbox_answer" != "${dropbox_answer#[Yy]}" ] ;then
    echo "Creating alias to Dropbox on Desktop..."
    mkdir -p ~/Dropbox
    ln -s ~/Dropbox ~/Desktop
    echo "${GREEN}Done."
else
    echo "Skipping configuration of dropbox"
fi

# TODO: Handle getting/setting up VMs
# TODO: Handle setup of VSCode defaults + snippets
# TODO: Handle setup of iterm defaults
# TODO: Handle setup of BTT defaults
# TODO: Install zshell
# TODO: Set env variables for PIA + Remove dependency on a private bash file