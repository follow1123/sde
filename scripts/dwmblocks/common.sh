#!/bin/bash



# 根据配置文件内的key获取值
function get_value(){
	awk -v key="$1" -F '=' '$0 ~ key{print $2}' "$(cd $(dirname $0); pwd)/config.properties"
}

# 设置配置文件key对应的值
function set_value(){
	key="$1"
	new_value="$2"
	sed -i "s/\($key=\).*/\1$new_value/" "$(cd $(dirname $0); pwd)/config.properties"
}

# 判断是否显示图标
function is_show(){
	get_value show_all
}

# 设置显示图标
function show(){
	set_value show_all 1
}

# 设置隐藏图标
function hide(){
	set_value show_all 0
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
