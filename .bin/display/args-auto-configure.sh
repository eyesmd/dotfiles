#!/bin/bash

source $HOME/.bin/display/display_functions.sh

if isConnected HDMI-1
then
    notify-send "Dual setup detected"
    echo "--output DP-1 --off --output HDMI-1 --mode 1600x900 --pos 0x0 --rotate normal --output eDP-1 --primary --mode 1366x768 --pos 128x900 --rotate normal --output HDMI-2 --off"
else
    notify-send "Single setup detected"
    echo "--output DP-1 --off --output HDMI-1 --off --output eDP-1 --primary --mode 1366x768 --pos 0x0 --rotate normal --output HDMI-2 --off"
fi

