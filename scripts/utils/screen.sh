#!/bin/bash

function get_screen_width(){
	xdpyinfo | awk '/dimensions/{print $2}' | awk -F 'x' '{print $1}'
}

function get_screen_height(){
	xdpyinfo | awk '/dimensions/{print $2}' | awk -F 'x' '{print $2}'
}


function get_width_index(){
	echo "$(get_screen_width) * $1" | bc
}

function get_height_index(){
	echo "$(get_screen_height) * $1" | bc
}
