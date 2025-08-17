#!/bin/bash
# [ $? -eq 0 ] checks if the previous command succeeded

set -e  # Exit script if any command fails

# First setup the WM config
cp -r config/* ~/.config

# Keyboard Setup
cd "Keyboard Layouts" 
cp .Xmodmap ~/.Xmodmap 
cp change_to_dvorak.sh ~ 
bash ~/change_to_dvorak.sh 

# Setup Zsh Config
cd .. 
cp -r zsh/* ~ 

# Neovim Setup
mkdir -p ~/.config/nvim 
cd ~/Documents 
git clone git@github.com:Z-Alos/Neovim-Config.git 
cp -r Neovim-Config/* ~/.config/nvim 
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim

