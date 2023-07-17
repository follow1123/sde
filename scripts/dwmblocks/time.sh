#!/bin/bash

source "$(cd $(dirname $0); pwd)/common.sh"

case $BLOCK_BUTTON in
	1) notify-send "$(date '+%Y-%m-%d %H:%M:%S')";;
	7) "$(get_terminal)" -e "$(get_editor)" "$0";;
esac

printf "%s" "$(date '+%m-%d %H:%M:%S')"
