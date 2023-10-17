#!/bin/bash

source $SDE_SCRIPTS/utils/screen.sh

# 显示系统托盘
show(){
	local margin=$(get_width_index 0.05)
	local height_padding=$(get_height_index 0.05)
	# 托盘靠底部
	# 托盘靠右
	# 托盘靠左右边距
	# 托盘宽度为屏幕宽度的15%
	# 托盘宽度为50px
	# 托盘靠上下边距
	# 图标的间距
	# 托盘颜色#2b2b2b
	# 是否透明
	# 透明度
	trayer \
		--edge bottom \
		--align right \
		--margin $margin \
		--width 15 \
		--height 50 \
		--distance $height_padding \
		--iconspacing 10 \
		--tint 0xFF2b2b2b \
		--transparent true \
		--alpha 0
}

# 隐藏系统托盘
hide(){
	killall trayer
}

# 判断系统托盘是否在运行，并返回pid
is_running(){
	pidof trayer
}
