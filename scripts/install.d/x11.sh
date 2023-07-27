#!/bin/bash

# dotfile文件目录
DOTFILE_HOME=$HOME/sde/x

if [ ! -d "$DOTFILE_HOME" ]; then
	echo "dotfile不存在，需要先clone space仓库再下载子模块"
	exit
fi

function config(){
	echo "开始配置x11"
	ln -s $DOTFILE_HOME/xinitrc $HOME/.xinitrc
}

config
