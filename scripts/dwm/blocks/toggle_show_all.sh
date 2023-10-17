#!/bin/bash

source "$DWM_BK_SCRIPTS/util.sh"

function update_bks(){
	update_battery
	update_bluetooth
}

if [ "$(is_show)" -eq 1 ]; then
	hide
	update_bks
else
	show
	update_bks
fi
