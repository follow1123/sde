#!/bin/bash

source "$(cd $(dirname $0); pwd)/common.sh"

function update_bks(){
	update_battery
	update_bluetooth
}

if [ "$(is_show)" = "1" ]; then
	hide
	update_bks
else
	show
	update_bks
fi
