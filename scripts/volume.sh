#!/bin/bash

# 判断是否静音
function is_mute(){
	if [ -n "$(amixer sget Master | grep '\[on\]')" ]; then
		echo 0
	else
		echo 1
	fi
}

# 获取音量大小
function get_level(){
	local level=$(amixer sget Master | awk -F '[][]' 'END{print $2}')
	echo ${level%?}
}

# 静音/取消静音
function toggle(){
	amixer sset Master toggle > /dev/null
}

# 增加音量
function inc_volume(){
	amixer sset Master "$1%+" > /dev/null && notify_volume
}

# 减少音量
function dec_volume(){
	amixer sset Master "$1%-" > /dev/null && notify_volume
}

# 设置音量
function set_volume(){
	amixer sset Master "$1%" > /dev/null
}

function notify_volume(){
	notify-send -r 9124 -h int:value:$(get_level) -h string:hlcolor:#00b7c3 '音量'
}
