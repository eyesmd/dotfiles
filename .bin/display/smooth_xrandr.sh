#!/bin/bash

# This script receives an argument which substitutes for a set of xrandr
# arguments (I'll use other scripts).
# It applies those arguments while dimming the lights of the displays
# to hide visual imperfections that occur after an xrandr config is
# applied.

DISPLAY_ROOT=$HOME/.bin/display

source $DISPLAY_ROOT/display_functions.sh

# get main xrandr args via argument
if [ "$#" != 1 ]
then
    echo "Wrong arguments: A single script file which sends xrandr arguments to stdout should be provided. Stopping." >&2
    exit 1
fi

main_xrandr_args=$($1) 


# function with 'output' brightness args to all enabled displays 
argsChangeGlobalBrightness() {
    if [ "$#" != 1 ]
    then
        echo "Wrong arguments for 'argsChangeGlobalBrightness': A single brightness value between 0 a 1 should be supplied. Stopping." >&2
        exit 1
    fi

    brightness_xrandr_args=""
    for display in "${DISPLAYS[@]}"
    do
        if isConnected $display && ! (isDisabled $display)
        then
            brightness_xrandr_args+="--output $display --brightness $1 "
        fi
    done
}

isDisabled() {
    [[ $main_xrandr_args == *"--output $1 --off"* ]]
}


# apply config and lights out
argsChangeGlobalBrightness 0.0
xrandr $main_xrandr_args $brightness_xrandr_args  

# wait
sleep 1.0

# fix displays and lights up
feh --bg-fill $HOME/.dotfiles/.background-image
argsChangeGlobalBrightness 1.0
xrandr $brightness_xrandr_args

