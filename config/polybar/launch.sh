#!/bin/bash

pkill -x polybar
while pgrep -x polybar >/dev/null; do sleep 1; done
polybar main 2>&1 | tee -a /tmp/polybar1.log & disown &

echo "Polybar launched..."
