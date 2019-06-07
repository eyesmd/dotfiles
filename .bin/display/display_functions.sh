#!/bin/bash

DISPLAYS=(eDP-1 HDMI-1)

isConnected() {
    xrandr | grep -q "$1 connected"
}

