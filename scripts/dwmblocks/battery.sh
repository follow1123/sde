#!/bin/bash

source "$(cd $(dirname $0); pwd)/common.sh"

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

function get_battery_level(){
	cat /sys/class/power_supply/BAT*/capacity
}

function defalut_event(){
	battery_level=$(get_battery_level)
	if [ $battery_level -ge 60 ] && [ "$(is_show)" = "0" ]; then
		print_empty
		exit
	fi
	if [ $battery_level -le 10 ]; then
		printf "%s" "$icon_bat_10"
	elif [ $battery_level -le 20 ]; then
		printf "%s" "$icon_bat_20"
	elif [ $battery_level -le 30 ]; then
		printf "%s" "$icon_bat_30"
	elif [ $battery_level -le 40 ]; then
		printf "%s" "$icon_bat_40"
	elif [ $battery_level -le 50 ]; then
		printf "%s" "$icon_bat_50"
	elif [ $battery_level -le 60 ]; then
		printf "%s" "$icon_bat_60"
	elif [ $battery_level -le 70 ]; then
		printf "%s" "$icon_bat_70"
	elif [ $battery_level -le 80 ]; then
		printf "%s" "$icon_bat_80"
	elif [ $battery_level -le 90 ]; then
		printf "%s" "$icon_bat_90"
	elif [ $battery_level -le 100 ]; then
		printf "%s" "$icon_bat_100"
	fi
}

if [ -z "$BLOCK_BUTTON" ]; then
	defalut_event
	exit
fi

case $BLOCK_BUTTON in
	1) notify-send $(get_battery_level);;
	7) "$(get_terminal)" -e "$(get_editor)" "$0";;
esac

defalut_event
