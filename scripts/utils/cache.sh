#!/bin/bash

source $SDE_SCRIPTS/utils/properties.sh

# 判断缓存文件是否存在，没有则创建一个
function check_and_create(){
	local cache_file="/tmp/$1"
	# 如果文件不存在，则创建一个空文件
	if [ ! -f "$cache_file" ]; then
		touch "$cache_file"
	fi
	echo "$cache_file"
}

# 根据配置文件内的key获取缓存
function get_cache(){
	local cache_file=$(check_and_create $1)
	get_prop $cache_file $2
}

# 设置配置文件key对应的缓存
function set_cache(){
	local cache_file=$(check_and_create $1)
	set_prop $cache_file $2 $3
}
