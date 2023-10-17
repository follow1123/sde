#!/bin/bash

source $SDE_SCRIPTS/light.sh


param=$1

if [ "$param" == "inc" ]; then
	inc_light 5
else
	dec_light 5
fi

notify-send -r 9123 -h int:value:`light` -h string:hlcolor:#00b7c3 '亮度'
