#!/bin/bash

# 加载显示相关函数
source $SDE_SCRIPTS/display/display.sh

local_display_name=$(get_local_display)

others_display=$(get_others_display)

for display_name in $others_display; do
	if [ "$(is_connected $display_name)" -eq 1 ]; then
		output $display_name
		off $local_display_name
		exit
	fi
done

output $local_display_name
