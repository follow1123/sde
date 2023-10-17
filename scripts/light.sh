#!/bin/bash

function get_light(){
	light
}

function inc_light(){
	light -A $1
}

function dec_light(){
	light -U $1
}

function set_light(){
	light -S $1
}
