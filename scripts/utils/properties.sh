#!/bin/bash

# 根据配置文件内的key获取值
function get_prop(){
	awk -v key="$2" -F '=' '$0 ~ "^"key{print $2}' "$1"
}

# 设置配置文件key对应的值
function set_prop(){
	local file=$1
	local key=$2
	local value=$3
	if [ "$(is_contains $file $key)" -eq 1 ]; then
		sed -i "s/\($key=\).*/\1$value/" "$file"
	else
		echo "$key=$value" >> $1
	fi
}

# 判断key是否存在
function is_contains(){
	local file=$1
	if [ -n "$(cat $file | grep "^$2")" ]; then
		echo 1
	else
		echo 0
	fi
}
