#!/bin/bash

source "$(cd $(dirname $0); pwd)/common.sh"

case $BLOCK_BUTTON in
	7) "$(get_terminal)" -e "$(get_editor)" "$0";;
esac

# 星期
week_info=$(date "+%w")
case ${week_info} in 
	1)
		week_info="周一"
		;;
	2)
		week_info="周二"
		;;
	3)
		week_info="周三"
		;;
	4)
		week_info="周四"
		;;
	5)
		week_info="周五"
		;;
	6)
		week_info="周六"
		;;
	0)
		week_info="周日"
		;;
	*)
		week_info="error"	
		;;
esac
printf "%s" "$week_info"
