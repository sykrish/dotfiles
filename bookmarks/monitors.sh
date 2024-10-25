#!/usr/bin/env sh

case "$1" in
    home)
        export SWAY_MONITOR=HDMI-A-1
        ~/scripts/sway/to-external.sh
        ;;

    work)
        export SWAY_MONITOR=DP-2
        ~/scripts/sway/to-external.sh
        ;;

    *)
        printf "home\nwork"
        ;;
esac

