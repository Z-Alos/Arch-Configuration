#!/bin/bash  # To make sure it runs in bash

#Variables
#Applications
BROWSER="firefox"
FILE_MANAGER="dolphin"
PLAYER="vlc"

#Paths
TELEGRAM_DOWNLOAD_URL="https://web.telegram.org/k/#@Bleach_Thousand_Year_Blood_War_5"
ANIME_FILLER_LIST_URL="https://www.animefillerlist.com/shows/bleach"
ANIME_EPISODE_DOWNLOAD_DIR="$HOME/Downloads"
ANIME_EPISODE_DIR="$HOME/Downloads/Bleach"

#Opening In Browser
$BROWSER "$TELEGRAM_DOWNLOAD_URL" & # & is used to continue running the command without waiting for the current program to close
$BROWSER "$ANIME_FILLER_LIST_URL" &
sleep 1
$PLAYER "$ANIME_EPISODE_DIR" &
$FILE_MANAGER "$ANIME_EPISODE_DIR" &

#Moving Anime Episode From Download Dir to Anime Playlist
mv "$ANIME_EPISODE_DOWNLOAD_DIR/Bleach ["* "$ANIME_EPISODE_DIR"

#Adjusting Volume
wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.8 # 80%
