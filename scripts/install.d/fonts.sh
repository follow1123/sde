#!/bin/bash

# 文件下载目录
DOWNLOADS_DIR=$HOME/Downloads

# 字体目录
FONTS_HOME=/usr/share/fonts



if [ ! -d "$DOWNLOADS_DIR" ]; then
	echo "用户下载目录\"$DOWNLOADS_DIR\"不存在，已创建目录"
	mkdir -p $DOWNLOADS_DIR
fi


# 安装软件
function install(){
	echo "开始安装字体"
	# 安装中文字体
	sudo apt install fonts-wqy-microhei -y
	# 下载字体文件
	wget -P $DOWNLOADS_DIR https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/FiraMono.zip
	wget -P $DOWNLOADS_DIR https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/JetBrainsMono.zip
	wget -P $DOWNLOADS_DIR https://github.com/ryanoasis/nerd-fonts/releases/download/v3.0.2/NerdFontsSymbolsOnly.zip
	wget -P $DOWNLOADS_DIR https://download.jetbrains.com/fonts/JetBrainsMono-2.304.zip
	# 解压字体文件
	sudo unzip FiraMono -d $FONTS_HOME/FiraMono
	sudo unzip JetBrainsMono -d $FONTS_HOME/JetBrainsMono
	sudo unzip NerdFontsSymbolsOnly -d $FONTS_HOME/NerdFontsSymbolsOnly
	local jbfont=$DOWNLOADS_DIR/fonts
	unzip JetBrainsMono-2.304.zip -d $DOWNLOADS_DIR/fonts
	sudo mv $DOWNLOADS_DIR/fonts/fonts/* $FONTS_HOME
	# 刷新字体文件
	cd $FONTS_HOME
	sudo mkfontscale
	sudo mkfontdir
	sudo fc-cache -fv
}

install
