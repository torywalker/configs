#!/bin/bash
# Description: Update the profile after it has changed

# Add Color Options
GREEN='\033[0;32m'

echo -n "Do you wish to replace the current profile with he new one (y/n)?"
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