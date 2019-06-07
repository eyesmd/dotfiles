#!/bin/bash

# This script receives an argument which substitutes for a set of xrandr
# arguments (I'll use other scripts).
# It applies those arguments while dimming the lights of the displays
# to hide visual imperfections that occur after an xrandr config is
# applied.

DISPLAY_ROOT=$HOME/.bin/display

source $DISPLAY_ROOT/display_functions.sh

argsChangeGlobalBrightness() {
    if [ "$#" != 1 ]
    then
        echo "Wrong arguments: A single brightness value between 0 a 1 should be supplied. Stopping." >&2
        exit 1
    fi
    
    brightness_xrandr_args=""
    for display in "${DISPLAYS[@]}"
    do
        if isConnected $display 
        then
            brightness_xrandr_args+="--output $display --brightness $1 "
        fi
    done
}

# apply config and lights out
argsChangeGlobalBrightness 0.0
xrandr $($1) $brightness_xrandr_args  

# wait
sleep 1.0

# fix displays and lights up
feh --bg-fill $HOME/.dotfiles/.background-image
argsChangeGlobalBrightness 1.0
xrandr $brightness_xrandr_args

