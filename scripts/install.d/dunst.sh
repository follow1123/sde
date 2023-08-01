#!/bin/bash

# 配置文件的目录
CONFIG_HOME=$HOME/.config
# dotfile文件目录
DOTFILE_HOME=$HOME/sde/dunst


if [ ! -d "$CONFIG_HOME" ]; then
	echo "用户配置目录\"$CONFIG_HOME\"不存在，已创建目录"
	mkdir -p $CONFIG_HOME
fi

if [ ! -d "$DOTFILE_HOME" ]; then
	echo "dotfile不存在，需要先clone space仓库再下载子模块"
	exit
fi

function libraries(){
	echo "开始安装通知服务依赖库"
	sudo apt install libnotify-dev libxss-dev -y
	sudo apt install libnotify-bin -y
}

# 安装软件
function install(){
	echo "开始安装dunst"
	cd $HOME/space/soft && \
	git clone https://github.com/dunst-project/dunst.git && \
	cd dunst && \
	make WAYLAND=0 && \
	sudo make install
}

function config(){
	echo "开始配置dunst"
	ln -s $DOTFILE_HOME $CONFIG_HOME
}

libraries
install
config
