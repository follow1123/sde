#!/bin/bash

netcard=wlp0s20f3
# 开启wpa_supplicant 服务
function start_wpa(){
	sudo wpa_supplicant -B -i $1 -c /etc/wpa_supplicant/wpa_supplicant.conf
}

# 添加一个wifi
function add_network(){
	local net_id=$(sudo wpa_cli -i $netcard add_network)
	sudo wpa_cli -i $netcard set_network $net_id ssid "$1" > /dev/null
	sudo wpa_cli -i $netcard set_network $net_id psk "$2" > /dev/null
	sudo wpa_cli -i $netcard set_network $net_id priority 2 > /dev/null
	sudo wpa_cli -i $netcard set_network $net_id scan_ssid 1 > /dev/null
	sudo wpa_cli -i $netcard save_config > /dev/null
}

# 连接wifi
function connect(){
	sudo wpa_cli -i $netcard enable_network $1 > /dev/null
	sudo wpa_cli -i $netcard select_network $1 > /dev/null
}

# 重新分配ip
function reload_ip(){
	sudo dhclient -r > /dev/null
	sudo dhclient > /dev/null
}

# 获取当前连接的wifi
function get_connected_name(){
	sudo wpa_cli -i $netcard list_networks | awk '/CURRENT/{print $2}'
}

# 获取已连接wifi的id
function get_connected_id(){
	sudo wpa_cli -i wlp0s20f3 list_networks | awk '/CURRENT/{print $1}'
}

