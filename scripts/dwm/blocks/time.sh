#!/bin/bash

source ~/.env

source "$DWM_BK_SCRIPTS/util.sh"

case $BLOCK_BUTTON in
	1) notify-send "$(date '+%Y-%m-%d %H:%M:%S')";;
	7) edit_script;;
esac

printf "%s" "$(date '+%m-%d %H:%M:%S')"
