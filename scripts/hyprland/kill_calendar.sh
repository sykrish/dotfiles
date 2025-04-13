#!/usr/bin/env sh

PID=$(hyprctl clients | grep -A 1 "initialTitle: calendar" \
    | head -n 2 \
    | grep pid \
    | awk '{print $2}')

if [[ $PID ]]; then
    kill $PID
    exit 1
else
    exit 0
fi
