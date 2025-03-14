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
ANIME_EPISODE_DIR="$HOME/Downloads/Bleach/Continue"
ANIME_WATCHED_EPISODE_DIR="$HOME/Downloads/Bleach/Watched"


#Moving Anime Episode From Download Dir to Anime Playlist
mv "$ANIME_EPISODE_DOWNLOAD_DIR/Bleach ["* "$ANIME_EPISODE_DIR"

#Adjusting Volume
wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.8 # 80%



# Use find with -print0 and readarray for safe filename handling
readarray -d '' fileNames < <(find "$ANIME_EPISODE_DIR" -type f -print0)
readarray -t mediaName < <(
    grep -oP 'list=.*' ~/.config/vlc/vlc-qt-interface.conf | 
    sed 's/list=//' | 
    sed -E 's/%([0-9A-Fa-f]{2})/\\x\1/g' | 
    xargs -0 printf '%b\n' | 
    tr ',' '\n'
)

readarray -t mediaTimeAt < <(
	grep -oP 'times=.*' ~/.config/vlc/vlc-qt-interface.conf | 
	sed 's/times=//' |
	tr ',' '\n')

for ((i = 0; i < ${#fileNames[@]}; i++)); do
	name=$(basename "${fileNames[$i]}")  # Extract filename

	echo "toFind::$name"
	readarray -t extractedName < <(printf "%s\n" "${mediaName[@]}" | sed "s|file://$ANIME_EPISODE_DIR||")

	
	for ((idx = 0; idx < ${#extractedName[@]}; idx++)); do
	 	if echo "${extractedName[$idx]}" | grep -iFq "$name"; then
	 		echo "Gotem::${extractedName[$idx]}"
			duration=$(mediainfo --Inform="General;%Duration%" "${fileNames[$i]}" 2>/dev/null | awk '{s+=$1/1000} END {print s}')
			#timeAt=$(echo "${mediaTimeAt[$idx]} / 1000" | bc -l)
			timeAt=$(awk "BEGIN { print ${mediaTimeAt[idx]} / 1000 }")
			echo "Duration::$duration"
			echo "TimeAt::${timeAt}"
			completed=$(awk "BEGIN { print (${timeAt}/${duration})*100}")
			echo "Completed::${completed}%"
			#if (( completed > 85 )); then
			if awk "BEGIN { exit !($completed > 85) }"; then
				mv -n "$ANIME_EPISODE_DIR/${extractedName[$idx]}" "${ANIME_WATCHED_EPISODE_DIR}"
			fi
	 		break	
	 	fi
	done
done
	
sync

#Opening In Browser
$BROWSER "$TELEGRAM_DOWNLOAD_URL" & # & is used to continue running the command without waiting for the current program to close
$BROWSER "$ANIME_FILLER_LIST_URL" &
sleep 1
#Playing
$PLAYER "$ANIME_EPISODE_DIR" &
$FILE_MANAGER "$ANIME_EPISODE_DIR" &