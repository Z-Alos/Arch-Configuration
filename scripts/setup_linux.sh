#!/bin/bash
# [ $? -eq 0 ] checks if the previous command succeeded

set -e  # Exit script if any command fails

# [Note] Prerequisite:- 
# Install all the packages
# Setup Git 

# First setup the WM config
xdg-user-dirs-update && \
cd ~/Documents && \
cd Arch-Configuration && \
cp -r config/* ~/.config

# Setup Zsh Config
cp -r ~/Documents/Arch-Configuration/zsh/.* ~ 

# Keyboard Setup
cd "Keyboard Layouts" 
cp Xmodmap_Dvorak.config ~/.Xmodmap 
cp change_to_dvorak.sh ~ 
bash ~/change_to_dvorak.sh 

# Neovim Setup
mkdir -p ~/.config/nvim 
cd ~/Documents 
git clone git@github.com:Z-Alos/Neovim-Config.git 
cp -r Neovim-Config/* ~/.config/nvim 
git clone --depth 1 https://github.com/wbthomason/packer.nvim ~/.local/share/nvim/site/pack/packer/start/packer.nvim
