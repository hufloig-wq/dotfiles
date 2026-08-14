#!/bin/bash
NAME="$1"
MAKE=$(hyprctl -j monitors all | jq -r --arg n "$NAME" '.[] | select(.name==$n) | .make')
echo "$MAKE" > /tmp/hypr-monitor-make
