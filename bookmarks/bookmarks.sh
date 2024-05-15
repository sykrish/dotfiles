#!/usr/bin/env sh

websites=~/dotfiles/bookmarks/websites

case "$1" in
    websites)
        cat -n $websites \
            | rofi -dmenu \
            | cut -d \; -f 2 \
            | xargs -r firefox && swaymsg workspace 10

        ;;

    *)
        printf "websites" | rofi -dmenu | xargs ./bookmarks.sh

        ;;

esac
