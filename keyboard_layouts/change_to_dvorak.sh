#!/bin/bash

setxkbmap us dvorak -option caps:swapescape &
xmodmap ~/.Xmodmap
xset r rate 140 70 &

