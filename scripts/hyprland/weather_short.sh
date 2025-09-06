#!/usr/bin/env sh

FILE=/tmp/weather_short

request() {
    WEATHER=$(curl -s https://wttr.in/Haarlem\?format="%t\n")
    echo $WEATHER > $FILE
}

get_weather() {
    if [ -f "$FILE" ]; then
        DATA=$(cat $FILE)

        if grep -q "please" <<< $DATA ; then
            : # do nothing
        else
            echo $DATA
        fi
    fi
}

case $1 in
    request)
        request
        ;;

    *)
        get_weather
        ;;
esac
