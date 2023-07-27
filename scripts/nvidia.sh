#!/bin/bash

# 驱动文件
DRIVER_FILE=$HOME/Downloads/NVIDIA-Linux-x86_64-535.54.03.run

# 黑名单目录
BLACKLIST_FILE=/etc/modprobe.d/blacklist.conf


if [ ! -e "$DRIVER_FILE" ]; then
	echo "NVIDIA驱动\"$CONFIG_HOME\"不存在，前往官网下载"
	exit
fi


# 禁用开源驱动
function blacklist(){
	local text="blacklist nouveau"
	echo "开始禁用开源驱动"
	if [ ! -e "$BLACKLIST_FILE" ]; then
		sudo touch $BLACKLIST_FILE
		sudo echo $text > $BLACKLIST_FILE
		echo "驱动已禁用，需要重启系统"
		exit
	else
		if [ -z "$(grep $text $BLACKLIST_FILE)" ]; then
			sudo echo $text >> $BLACKLIST_FILE
			echo "驱动已禁用，需要重启系统"
			exit
		fi
	fi
}

# 安装依赖
function libraries(){
	ehco "开始安装nvidia依赖包"
	sudo apt install build-essential libglvnd-dev linux-source linux-headers-$(uname -r) -y
}

# 安装软件
function install(){
	echo "开始安装"
	sudo bash $DRIVER_FILE -no-x-check
}


blacklist
libraries
install
