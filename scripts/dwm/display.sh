#!/bin/bash

source $SDE_SCRIPTS/display/display.sh


# 重新加载默认显示器配置
function reload_default(){
	$SCRIPTS/display/display_init.sh > /dev/null
}

# 连接到内置显示器
function connect_local(){
	local local_display_name=$(get_local_display)
	others_display=$(get_others_display)

	for display_name in $others_display; do
		if [ "$(is_connected $display_name)" -eq 1 ]; then
			off $display_name
			break
		fi
	done
	output $local_display_name
}

# 连接到外接显示器
function connect_external(){
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
}

# 使用rofi调用
declare -A event_map=(
	["reload screen"]="reload_default"
	["connect to local"]="connect_local"
	["connent to external"]="connect_external"
)

event_name=$(printf "%s\n" "${!event_map[@]}" | rofi -dmenu -window-title 'Screens' -no-show-icons)
if [ -n "$event_name" ];then
	tar_event=${event_map[$event_name]}
	$tar_event
fi

