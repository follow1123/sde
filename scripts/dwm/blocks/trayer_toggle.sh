#!/bin/bash

source $DWM_BK_SCRIPTS/util.sh

source $SDE_SCRIPTS/trayer.sh

icon_show=""
icon_hide=""
function toggle_show(){
	if [ -n "$(is_running)" ]; then
		hide
	else
		show
		# sleep 10
		# hide
	fi
}

# toggle_show &

case $BLOCK_BUTTON in
	1) toggle_show > /dev/null & ;;
	7) edit_script;;
esac
# 
if [ -n "$(is_running)" ]; then
	printf "%s" ""
else
	printf "%s" ""
fi
