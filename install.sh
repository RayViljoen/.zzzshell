#!/bin/zsh

# Welcome
echo "
   _____          _____ __         ____
  /__  /________ / ___// /_  ___  / / /
    / //_  /_  / \__ \/ __ \/ _ \/ / / 
 _ / /__/ /_/ /____/ / / / /  __/ / /  
(_)____/___/___/____/_/ /_/\___/_/_/
https://github.com/RayViljoen/zzzshell/
"
# .bashdots dir
BD_DIR="$(dirname "$0")"

# Change to .bashdots
cd "$BD_DIR"

##########################################
# DO ANY ONE-TIME SETUPS HERE

# Disable key hold
# defaults write -g ApplePressAndHoldEnabled -bool false

##########################################

# Install
function linkIt() {

    # Create .rc symlink
    ln -sf $PWD/.zshrc ~/.zshrc

    # Restart
    echo "Done. Restart terminal to apply changes."
}

# Confirm symlinks
read "?Create .zshrc symlink and overwrite existing? (y/n)"
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    linkIt
fi

unset linkIt
