#!/bin/bash

# 配置文件的目录
CONFIG_HOME=$HOME/.config
# dotfile文件目录
DOTFILE_HOME=$HOME/sde/rofi


if [ ! -d "$CONFIG_HOME" ]; then
	echo "用户配置目录\"$CONFIG_HOME\"不存在，已创建目录"
	mkdir -p $CONFIG_HOME
fi

if [ ! -d "$DOTFILE_HOME" ]; then
	echo "dotfile不存在，需要先clone space仓库再下载子模块"
	exit
fi

function libraries(){
	echo "开始安装rofi依赖"
	sudo apt install papirus-icon-theme autotools-dev autoconf automake libtool -y
	sudo apt install libxcb1-dev libxcb-xkb-dev libxkbcommon-dev libxkbcommon-x11-dev libxcb-ewmh-dev libxcb-icccm4-dev libxcb-cursor-dev libxcb-randr0-dev libxcb-xinerama0-dev libxcb-util-dev libstartup-notification0-dev check -y
}

# 安装软件
function install(){
	cd $HOME/space/soft && \
	# git clone https://github.com/davatorium/rofi.git -b 1.7.4 && \
	cd rofi && \
	# git submodule update --init && \
	autoreconf -i && \
	mkdir -p build && \
	cd build && \
	$HOME/space/soft/rofi/configure && \
	make && \
	sudo make install
	# sudo apt install rofi -y
}

function config(){
	echo "开始配置rofi"
	ln -s $DOTFILE_HOME/files $CONFIG_HOME/rofi
}

libraries
install
config
