#!/bin/bash

SDE_HOME=$HOME/sde

if [ ! -d "$SDE_HOME" ]; then
	echo "sde不存在，需要先clone sde仓库再下载子模块"
	exit
fi


# 安装依赖
function libraries(){
	ehco "开始安装suckless依赖包"
	sudo apt install libx11-dev libxft-dev libxinerama-dev xorg make gcc libgtk-3-dev libgcr-3-dev libwebkit2gtk-4.0-dev -y
}

# 安装软件
function install(){
	echo "开始编译并安装suckless相关软件"
	cd $SDE_HOME/dwm && sudo make clean isntall
	cd $SDE_HOME/dwmblocks-async && sudo make clean isntall
	cd $SDE_HOME/st && sudo make clean isntall
	cd $SDE_HOME/surf && sudo make clean isntall

}

function config(){
	echo "开始配置neovim"
	ln -s $DOTFILE_HOME $CONFIG_HOME
}

libraries
install
