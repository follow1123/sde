#!/bin/bash

source $DWM_BK_SCRIPTS/util.sh

icon_bat_10="󰁺"
icon_bat_20="󰁻"
icon_bat_30="󰁼"
icon_bat_40="󰁽"
icon_bat_50="󰁾"
icon_bat_60="󰁿"
icon_bat_70="󰂀"
icon_bat_80="󰂁"
icon_bat_90="󰂂"
icon_bat_100="󰁹"

icon_charging_bat_10="󰢜"
icon_charging_bat_20="󰂆"
icon_charging_bat_30="󰂇"
icon_charging_bat_40="󰂈"
icon_charging_bat_50="󰢝"
icon_charging_bat_60="󰂉"
icon_charging_bat_70="󰢞"
icon_charging_bat_80="󰂊"
icon_charging_bat_90="󰂋"
icon_charging_bat_100="󰂅"

# 获取电量
function get_battery_level(){
	cat /sys/class/power_supply/BAT*/capacity
}

# 获取电池信息
function get_battery_status(){
	cat /sys/class/power_supply/BAT*/status
}

function defalut_event(){
	battery_level=$(get_battery_level)
	if [ $battery_level -ge 60 ] && [ "$(is_show)" = "0" ]; then
		print_empty
		exit
	fi
	# 向上取到10位数
	level_top=$(((($battery_level + 9) / 10) * 10))
	# 判断是否在充电
	if [ "$(get_battery_status)" = "Charging" ]; then
		icon_name="icon_charging_bat_$level_top"
	else
		icon_name="icon_bat_$level_top"
	fi

	printf "%s" "${!icon_name}"
}

if [ -z "$BLOCK_BUTTON" ]; then
	defalut_event
	exit
fi

case $BLOCK_BUTTON in
	1) notify-send $(get_battery_level);;
	7) edit_script;;
esac

defalut_event
