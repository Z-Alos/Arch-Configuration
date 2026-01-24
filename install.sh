#!/usr/bin/bash
set -e 

# [Note] Prerequisite:- 
# Setup Git 
# Make sure you have this repo in $HOME dir

DOTFILES="$HOME/martian_dotfiles"
echo "Deploying martian dotfiles"

# -------------------------
# Install Packages
# -------------------------
echo "Installing Packages"

# Ensure yay exists
if ! command -v yay >/dev/null 2>&1; then
    echo "Installing yay"

    sudo pacman -Syu --needed --noconfirm base-devel

    TMP_DIR="$(mktemp -d)"
    git clone https://aur.archlinux.org/yay.git "$TMP_DIR/yay"
    cd "$TMP_DIR/yay"
    makepkg -si --noconfirm

    cd "$HOME"
    rm -rf "$TMP_DIR"
else
    echo "yay already installed"
fi

sudo pacman -Syu --needed - < "$DOTFILES/packages/pacman_packages.txt"
# yay -S --needed - < "$DOTFILES/packages/yay_packages.txt"

# -------------------------
# XDG directories
# -------------------------
xdg-user-dirs-update

# -------------------------
# ~/.config symlinks
# -------------------------
echo "Linking ~/.config"
mkdir -p "$HOME/.config"

for dir in "$DOTFILES"/config/*; do
    name=$(basename "$dir")
    ln -sfn "$dir" "$HOME/.config/$name"
done

# -------------------------
# ~home symlinks
# -------------------------
echo "Linking home dotfiles"

for file in "$DOTFILES"/home/{*, .*}; do
    name=$(basename "$file")
    [[ "$name" == "." || "$name" == ".." ]] && continue
    ln -sfn "$file" "$HOME/$name"
done

# -------------------------
# Sddm Theme
# -------------------------
echo "Setting Up Sddm Theme, You may have to enter your Password..."

sudo cp -r \
  "$DOTFILES/system/sddm/martian" \
  "/usr/share/sddm/themes/martian"

sudo mkdir -p /etc/sddm.conf.d
sudo tee /etc/sddm.conf.d/theme.conf > /dev/null <<EOF
[Theme]
Current=martian
EOF

# -------------------------
# Zsh + Powerlevel10k
# -------------------------
echo "Setting up Zsh"

# Change default shell 
if [[ "$SHELL" != "/bin/zsh" ]]; then
    chsh -s /bin/zsh
    echo "→ Default shell set to zsh (re-login required)"
fi

# Install Powerlevel10k 
mkdir -p ~/.local/share
P10K_DIR="$HOME/.local/share/powerlevel10k"
if [[ ! -d "$P10K_DIR" ]]; then
    echo "Installing Powerlevel10k"
    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git "$P10K_DIR"
else
    echo "Powerlevel10k already installed"
fi

# -------------------------
# Keyboard layout
# -------------------------
echo " Setting up keyboard layout"
ln -sfn "$DOTFILES/keyboard_layouts/xmodmap_dvorak.config" "$HOME/.Xmodmap"
ln -sfn "$DOTFILES/keyboard_layouts/change_to_dvorak.sh" "$HOME/change_to_dvorak.sh"
bash "$HOME/change_to_dvorak.sh"

# -------------------------
# Neovim 
# -------------------------
echo "Neovim setup"

PACKER_DIR="$HOME/.local/share/nvim/site/pack/packer/start/packer.nvim"
if [[ ! -d "$PACKER_DIR" ]]; then
    git clone --depth 1 https://github.com/wbthomason/packer.nvim "$PACKER_DIR"
fi

echo "Rice deployed successfully"

