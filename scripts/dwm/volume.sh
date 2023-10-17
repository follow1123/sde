#!/bin/bash

source $SDE_SCRIPTS/volume.sh

source $DWM_BK_SCRIPTS/util.sh

param=$1

if [ "$param" == "inc" ]; then
	inc_volume 2
elif [ "$param" == "dec" ]; then
	dec_volume 2
elif [ "$param" == "mute" ]; then
	toggle
fi

update_volume
