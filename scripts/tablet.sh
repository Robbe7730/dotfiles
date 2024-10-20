#!/bin/sh

# MONITOR="HDMI-0"
MONITOR="eDP-1-1"
PAD_NAME='Wacom Intuos Pro M Pad pad'

#undo
xsetwacom --set "$PAD_NAME" Button 1 "key +ctrl +z -z -ctrl" 

#define next 2 however you like, I have mine mapped for erase in krita
xsetwacom --set "$PAD_NAME" Button 2 "key e"
xsetwacom --set "$PAD_NAME" Button 3 "key h"

ID_STYLUS=`xinput | grep "Pen stylus" | cut -f 2 | cut -c 4-5`
xinput map-to-output $ID_STYLUS $MONITOR
echo "Remapping $ID_STYLUS to $MONITOR"

ID_STYLUS=`xinput | grep "Pen eraser" | cut -f 2 | cut -c 4-5`
xinput map-to-output $ID_STYLUS $MONITOR
echo "Remapping $ID_STYLUS to $MONITOR"
