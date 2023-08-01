#!/bin/bash

# 安装软件
function install(){
	echo "开始安装其他软件"
	sudo apt install trayer feh nemo playerctl polkit-kde-agent-1 light -y
}

install
