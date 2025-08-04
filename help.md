# Graphics Driver (GT 710 - Trash)
- install 470xx-dkms and 470xx-utils
- remove nouveau completely
- tinker around (most imp step)

# Fonts
- nvim ~/.Xresources
- Add these lines:

Xft.antialias: true
Xft.hinting: true
Xft.hintstyle: hintfull
Xft.rgba: rgb
Xft.dpi: 96

- xrdb -merge ~/.Xresources

## Install these
- yay -S ttf-liberation ttf-dejavu freetype2-infinality
- fc-cache -fv
