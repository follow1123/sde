#!/bin/bash

source $SDE_SCRIPTS/utils/properties.sh

prop_file=$DWM_BK_SCRIPTS/config.properties

# 根据配置文件内的key获取值
function get_value(){
	get_prop $prop_file $1
}

# 设置配置文件key对应的值
function set_value(){
	set_prop $prop_file $1 $2
}

# 后台编辑当前脚本
function edit_script(){
	nohup "$(get_terminal)" -e "$(get_editor)" "$0" > /dev/null &
}

# 获取编辑使用的终端
function get_terminal(){
	get_value terminal
}

# 获取编辑使用的编辑器
function get_editor(){
	get_value editor
}

# 根据状态key更新状态信息
function update_blocks(){
	kill -$(expr 34 + $(get_value $1)) $(pidof dwmblocks) > /dev/null
}

function update_icon(){
	update_blocks block_icon
}

function update_volume(){
	update_blocks block_volume
}
function update_bluetooth(){
	update_blocks block_bluetooth
}
function update_battery(){
	update_blocks block_battery
}
function update_time(){
	update_blocks block_time
}
function update_week(){
	update_blocks block_week
}
function update_trayer(){
	update_blocks block_trayer
}


function print_empty(){
	printf "%s" ""
}

function print_str(){
	printf "%s" "$1"
}
