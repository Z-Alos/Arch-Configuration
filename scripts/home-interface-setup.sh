#!/bin/bash

SESSION="Home Interface"

tmux new-session -d -s "$SESSION" 

tmux rename-window -t "$SESSION:0" "Server" 

tmux send-keys -t "$SESSION:0" "cd ~/Documents/fun/home-interface/ && npm run start" C-m

tmux new-window -t "$SESSION" -n "Friday" 
tmux send-keys -t "$SESSION:1" "cd ~/Documents/FRIDAY/ && source fridayEnv/bin/activate && python ./friday.py" C-m

tmux new-window -t "$SESSION" -n "Audio Visualizer" 
tmux send-keys -t "$SESSION:2" "firefox --new-window https://friday-av.web.app" C-m

tmux attach-session -t "$SESSION"

