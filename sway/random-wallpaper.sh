#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="/home/davis/wallpapers"

# Pick a random file (jpg, png)
WALLPAPER=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.png" \) | shuf -n 1)
echo "Setting wallpaper: $WALLPAPER"
# Output the Sway command
pkill swaybg
swaybg -i "$WALLPAPER" -m fill &
wal -n -i "$WALLPAPER"



