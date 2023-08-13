#!/bin/bash

case "$1" in
	# 系统休眠前执行
    pre)
    ;;
	# 系统恢复后执行
    post)
		# 设置默认按键速率等
		bash /home/yf/space/scripts/keyboard/default_keyboard_opts.sh
	;;
esac

exit 0


