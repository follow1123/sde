#!/bin/bash

# 蓝牙相关函数
source $HOME/space/scripts/bluetooth/bluetooth.sh
# 声音相关函数
source $HOME/space/scripts/volume/volume.sh

source "$(cd $(dirname $0); pwd)/common.sh"


# 蓝牙状态相关图标
icon_power_on="󰂯"
icon_power_off="󰂲"
icon_connected="󰂱"

# 默认连接的蓝牙设备
device=78:A7:EB:03:83:DC
# 音量默认大小
volume=30

#  函数定义

# 连接默认蓝牙并设置音量
function connect_and_set_volume(){
	connect $device
	sleep 3
	set_volume $volume
	update_volume
}

# 没有点击事件的默认处理事件
function defalut_event(){
	if [ "$(is_powered)" -eq 1 ]; then 
		if [ "$(is_connected)" -eq 1 ]; then 
			printf "%s" "$icon_connected"
		else
			printf "%s" "$icon_power_on"
		fi
	else
		if [ "$(is_show)" = "0" ]; then
			print_empty
			exit
		fi
		printf "%s" "$icon_power_off"
	fi
}

# 无点击事件时默认的输出
if [ -z "$BLOCK_BUTTON" ];then
	defalut_event
	exit
fi

# 点击事件
case  $BLOCK_BUTTON in
	# 左键点击
	# 判断蓝牙是否开启
	#	已开启 则判断蓝牙是否连接
	#		已连接 则断开蓝牙
	#		未连接 则连接默认配置的蓝牙
	#	未开启 则打开蓝牙并连接默认配置的蓝牙
	1)
		if [ "$(is_powered)" -eq 1 ]; then 
			if [ "$(is_connected)" -eq 1 ]; then 
				disconnect $device
				printf "%s" "$icon_power_on"
			else
				connect_and_set_volume
				printf "%s" "$icon_connected"
			fi
		else
			power_on
			sleep 1
			connect_and_set_volume
			printf "%s" "$icon_connected"
		fi
		exit
		;;
	# 中键（滚轮）点击
	# 开启/关闭蓝牙
	2)
		if [ "$(is_powered)" -eq 1 ]; then 
			power_off
			if [ "$(is_show)" = "0" ]; then
				print_empty
				exit
			fi
			printf "%s" "$icon_power_off"
		else
			power_on
			printf "%s" "$icon_power_on"
		fi
		exit
		;;
	# 右键点击
	# 弹出rofi选择框选择一个已配对的蓝牙设备
	# 是否选择蓝牙设备
	#	已选择 则判断蓝牙是否开启
	#		蓝牙已开启 判断蓝牙是否连接
	#			已连接 则判断是否是同一个设备，是则不做操作，否则断开蓝牙重新连接
	#			未连接 则连接选择的蓝牙
	#		蓝牙未开启 则开启蓝牙并连接选择的蓝牙
	#	未选择 则按默认方式处理
	3)
		sel_device=$(select_devices)
		if [ -n "$sel_device" ]; then
			if [ "$(is_powered)" -eq 1 ]; then 
				if [ "$(is_connected)" -eq 1 ]; then
					if [ "$device" != "$sel_device" ];then
						disconnect $device
						device=$sel_device
					fi
				fi
				connect_and_set_volume
			else
				power_on
				sleep 1
				device=$sel_device
				connect_and_set_volume
			fi
			printf "%s" "$icon_connected"
		else
			defalut_event
		fi
		exit
		;;
	7) "$(get_terminal)" -e "$(get_editor)" "$0";;
esac
defalut_event
