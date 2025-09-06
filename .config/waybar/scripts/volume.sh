#!/bin/sh

show() {
    VOLUME=$(pactl get-sink-volume @DEFAULT_SINK@ | awk '{print $5}')

    if [ $(pactl get-sink-mute @DEFAULT_SINK@ | awk '{print $2}') = 'yes' ]; then
        STATE="MUTED"
    else
        STATE="NOT_MUTED"
    fi

    jq --compact-output \
        --null-input \
        --arg text "$VOLUME" \
        --arg alt "$STATE" \
        --arg class "$STATE" \
        '{"text": $text, "class": $class, "alt": $alt}'
}

mute() {
    pactl set-sink-mute @DEFAULT_SINK@ toggle
}

switch_device() {
    #TODO toggle to headphones and speakers
    echo "todo"
}

case $1 in
    mute)
        mute;;

    show)
        show;;

    switch_device)
        switch_device;;

esac
