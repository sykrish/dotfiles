#!/usr/bin/env sh

case "$1" in
    inbox)
        # ~/scripts/sway/to-external.sh
        ;;

    shopping)
        rofi -dmenu \
        | (xargs todoist a -P $TODOIST_API_TOKEN)

        if [ $? -eq 0 ]; then
            notify-send -u low "Added to todo list"
        else
            notify-send -u critical "Failed to add to todo list"
        fi

        ;;

    *)
        printf "inbox\nshopping"
        ;;
esac
