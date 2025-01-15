#!/usr/bin/env sh

bookmarks=~/dotfiles/bookmarks/bookmarks.sh
websites=~/dotfiles/bookmarks/websites
monitors=~/dotfiles/bookmarks/monitors.sh
todoist=~/dotfiles/bookmarks/todoist.sh
tools=~/dotfiles/bookmarks/tools.sh
edit=~/dotfiles/bookmarks/edit

#TODO command bookmars? docs from org / obsidian? / greenclip
case "$1" in
    websites)
        cat -n $websites \
            | rofi -dmenu \
            | cut -d \; -f 2 \
            | (xargs -r -0 firefox && swaymsg workspace 10)

        ;;

    edit)
        cat -n $edit \
            | rofi -dmenu \
            | cut -d \; -f 2 \
            | xargs -r -0 -I % sh -c 'emacsclient -e "(+workspace/new)" | emacsclient -n %' && swaymsg workspace 1

        ;;
    monitors)
         $monitors \
            | rofi -dmenu \
            | (xargs ~/dotfiles/bookmarks/monitors.sh)

        ;;

    todoist)
         $todoist \
            | rofi -dmenu \
            | (xargs ~/dotfiles/bookmarks/todoist.sh)

        ;;
    tools)

        ;;
    *)
        printf "websites\nedit\nmonitors\ntodoist" | rofi -dmenu | xargs $bookmarks

        ;;

esac
