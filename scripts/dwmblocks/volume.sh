#!/bin/bash

# 声音相关函数
source $HOME/space/scripts/volume/volume.sh

source "$(cd $(dirname $0); pwd)/common.sh"


# 声音相关图标
icon_volume=""
icon_mute=""

# 每次增加或减少多大音量
level=5

case $BLOCK_BUTTON in
	# 中键（滚轮）点击，开启/静音
	2) toggle ;;
	# 滚轮向上，增加音量
	4) inc_volume $level ;;
	# 滚轮向下，减小音量
	5) dec_volume $level ;;
	7) "$(get_terminal)" -e "$(get_editor)" "$0";;
esac

# 默认显示音量图标
if [ "$(is_mute)" -eq 0 ]; then
	printf "%s" "$icon_volume$(get_level)%"
else
	printf "%s" "$icon_mute"
fi
