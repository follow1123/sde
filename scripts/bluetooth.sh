#!/bin/bash

# 开启蓝牙
function power_on(){
	bluetoothctl power on > /dev/null
}

# 关闭蓝牙
function power_off(){
	bluetoothctl power off > /dev/null
}

# 判断蓝牙是否打开
function is_powered(){
	if [ -n "$(bluetoothctl show | grep 'Powered: yes')" ]; then
		echo 1
	else
		echo 0
	fi
}

# 连接蓝牙
function connect(){
	bluetoothctl connect $1 > /dev/null
}

# 断开蓝牙
function disconnect(){
	bluetoothctl disconnect $1 > /dev/null
}

# 判断蓝牙是否连接
function is_connected(){
	if [ -n "$(bluetoothctl info $1 | grep 'Connected: yes')" ]; then
		echo 1
	else
		echo 0
	fi
}

# 选择一个蓝牙设备连接
function select_devices(){
	local device=$(bluetoothctl devices Paired | awk '{
	for (i = 3; i <= NF; i++){
		printf "%s ",$i
	}
	}' | rofi -dmenu -window-title 'bluetooth')
	if [ -n "$device" ];then
		device=${device%?}
		echo $(bluetoothctl devices | grep "$device" | awk '{print $2}')
	else
		echo ""
	fi
}
