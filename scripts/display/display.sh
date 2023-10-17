#!/bin/bash

source $SDE_SCRIPTS/utils/properties.sh

prop_file=$SDE_SCRIPTS/display/display.properties


# 判断对应显示器是否连接
function is_connected(){
	if [ -n "$(xrandr -q | grep "^$1 connected")" ]; then
		echo 1
	else
		echo 0
	fi
}

function get_info(){
	local name=$1
	local key=$2
	get_prop $prop_file "${name}_${key}"
}

# 输出显示设备
function output(){
	local name=$1
	local mode="$(get_info $name mode)"
	local rate="$(get_info $name rate)"
	local scale="$(get_info $name scale)"
	xrandr --output $name --mode $mode --rate $rate --scale $scale --auto > /dev/null
}

# 关闭显示设备
function off(){
	xrandr --output $1 --off > /dev/null
}

function get_local_display(){
	awk -F '_' '/local=true/{print $1}' $prop_file
}

function get_others_display(){
	local local=$(get_local_display)
	xrandr -q | grep "connect" | awk -v d="$local" '!($1 == d) {print $1}'
}

function get_all_display(){
	xrandr -q | grep "connect" | awk '{print $1}'
}

