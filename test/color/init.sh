#!/bin/bash

# This script shows Terminal Colors sample
# No Need To Change.

function create_sample_dirs() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))
	mkdir -p $this_dir/files
	cd files

	touch file.Black file.Black_light file.BG_Black file.BG_Black_light
	touch file.Red file.Red_light file.BG_Red file.BG_Red_light
	touch file.Green file.Green_light file.BG_Green file.BG_Green_light
	touch file.Orange file.Orange_light file.BG_Orange file.BG_Orange_light
	touch file.Blue file.Blue_light file.BG_Blue file.BG_Blue_light
	touch file.Purple file.Purple_light file.BG_Purple file.BG_Purple_light
	touch file.Cyan file.Cyan_light file.BG_Cyan file.BG_Cyan_light
	touch file.Grey file.Grey_light file.BG_Grey file.BG_Grey_light

	cd ../
	echo "finish create"
}

function color_init() {
	local this_dir=$(dirname $(type ${BASH_SOURCE:-$0} | awk '{print $NF}'))
	local ls_colors="\
		*.Black=30:   *.Black_light=90:   *.BG_Black=40:   *.BG_Black_light=100: \
		*.Red=31:     *.Red_light=91:     *.BG_Red=41:     *.BG_Red_light=101:   \
		*.Green=32:   *.Green_light=92:   *.BG_Green=42:   *.BG_Green_light=102: \
		*.Orange=33:  *.Orange_light=93:  *.BG_Orange=43:  *.BG_Orange_light=103:\
		*.Blue=34:    *.Blue_light=94:    *.BG_Blue=44:    *.BG_Blue_light=104:  \
		*.Purple=35:  *.Purple_light=95:  *.BG_Purple=45:  *.BG_Purple_light=105:\
		*.Cyan=36:    *.Cyan_light=96:    *.BG_Cyan=46:    *.BG_Cyan_light=106:  \
		*.Grey=37:    *.Grey_light=97:    *.BG_Grey=47:    *.BG_Grey_light=107:  \
	"

	# LS_COLORS does not allow including space char
	export LS_COLORS=$(echo $ls_colors | tr -d ' ')
	ls --color=auto $this_dir/files
}

create_sample_dirs
color_init
