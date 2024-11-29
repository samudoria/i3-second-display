#!/bin/bash

if [ "$#" -lt 1 ]; then
	echo "Usage: $0 {above, left-of, right-of, below, same-as, off)"
	exit 1
fi

direction=$1

blacklist=("above" "left-of" "right-of" "below" "same-as" "off")

found=false
for item in "${blacklist[@]}"; do
	if [ "$direction" = "$item" ]; then
        	found=true
        	break
    	fi
done

if [ "$found" = false ]; then
    	echo "wrong argument: $direction"
	exit 1
fi

primary_display=$(xrandr | grep " connected" | awk '{print $1}' | sed -n '1p')
second_display=$(xrandr | grep " connected" | awk '{print $1}' | sed -n '2p')

if [ "$1" != "off" ]; then
	xrandr --output $second_display --primary --auto --${direction} $primary_display
else
	xrandr --output $second_display --off && xrandr --output $primary_display --primary
fi
