#!/bin/bash

# 配置文件的目录
CONFIG_HOME=$HOME/.config
# dotfile文件目录
DOTFILE_HOME=$HOME/space/dotfiles/fcitx


if [ ! -d "$CONFIG_HOME" ]; then
	echo "用户配置目录\"$CONFIG_HOME\"不存在，已创建目录"
	mkdir -p $CONFIG_HOME
fi

if [ ! -d "$DOTFILE_HOME" ]; then
	echo "dotfile不存在，需要先clone space仓库再下载子模块"
	exit
fi

# 安装软件
function install(){
	echo "开始安装fcitx"
	sudo apt install fcitx fcitx-pinyin -y
}

function config(){
	echo "开始配置fcitx"
	cp -r $DOTFILE_HOME/skin/* $CONFIG_HOME/fcitx/skin
}

install
config


