#!/usr/bin/env sh

case "$1" in
inbox)
    # ~/scripts/sway/to-external.sh
    ;;

shopping)
    wofi --show dmenu |
        (xargs todoist a -P "$TODOIST_SHOPPING_LIST")

    echo "input: $1 - $?"
    if [ $? -eq 0 ]; then
        notify-send -u low "Added to todo list printenv"
    else
        notify-send -u critical "Failed to add to todo list"
    fi

    ;;

*)
    printf "inbox\nshopping"
    ;;
esac
