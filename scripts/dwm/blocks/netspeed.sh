#!/bin/bash

source $DWM_BK_SCRIPTS/util.sh

source $SDE_SCRIPTS/utils/cache.sh

case $BLOCK_BUTTON in
	7) edit_script;;
esac

cache_file="blocks_netspeed"

# 获取网络接口名称
interface=$(ip -o -4 route show to default | awk '{print $5}')

# 获取秒级别的时间戳
function get_timestamp(){
	date +%s
}

function get_by_cache(){
	get_cache $cache_file $1
}

function update_cache(){
	set_cache $cache_file $1 $2
}

# 获取上行或下行的流量（单位byte）,缓存的数据超过3秒则直接返回0
function get_speed(){
	local type=$1
	local last_bytes=$(get_by_cache last_${type}_bytes)
	local last_time=$(get_by_cache last_${type}_time)
	local cur_bytes=$(cat "/sys/class/net/$interface/statistics/${type}_bytes")
	local cur_time=$(get_timestamp)

	if [ -z "$last_time" ]; then
		last_time=$cur_time
	fi

	if [ -z "$last_bytes" ]; then
		last_bytes=$cur_bytes
	fi

	if [ $(($cur_time - $last_time)) -gt 3 ]; then
		last_bytes=$cur_bytes
	fi
	
	update_cache last_${type}_bytes $cur_bytes
	update_cache last_${type}_time $cur_time

	echo $(($cur_bytes - $last_bytes))
}

# 格式化流量，B、K、M、G
function format_speed(){
	local speed=$1
	if [ $speed -lt 1024 ]; then
		speed="${speed}B/s"
	elif [ $speed -lt 1048576 ]; then
		speed="$(($speed / 1024))K/s"
	elif [ $speed -lt 1073741824 ]; then
		speed="$(($speed / 1048576))M/s"
	else
		speed="$(($speed / 1073741824))G/s"
	fi
	echo $speed
}

printf "%6s" "$(format_speed $(($(get_speed rx) + $(get_speed tx))))"
