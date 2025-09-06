#!/usr/bin/env bash

DIR=~/Pictures/wallpapers/

WALLPAPER=$(ls $DIR | rofi -dmenu -show-icons -config ~/.config/rofi/colors.rasi)
WALLPAPER_PATH="$DIR$WALLPAPER"

if [[ -z "$WALLPAPER" ]]; then
    # User escaped rofi, we don't want to continue
    exit 0;
fi

pgrep swww-daemon 2>&1 > /dev/null && swww img $WALLPAPER_PATH  --transition-type center

case $WALLPAPER in
    3_dark.jpg)
        wal --saturate 0.3  -i Pictures/wallpapers/3_dark.jpg
        ;;

    *)
        wal --saturate 0.9  -i $WALLPAPER_PATH
        ;;
esac

wal -R

cp .cache/wal/colors-rofi-dark.rasi .config/rofi/colors.rasi
