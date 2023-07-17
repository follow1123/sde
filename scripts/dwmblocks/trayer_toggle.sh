#!/bin/bash

source "$(cd $(dirname $0); pwd)/common.sh"

case $BLOCK_BUTTON in
	1) $HOME/space/scripts/sys_trayer.sh > /dev/null ;; 
	7) "$(get_terminal)" -e "$(get_editor)" "$0";;
esac

printf "%s" ""
