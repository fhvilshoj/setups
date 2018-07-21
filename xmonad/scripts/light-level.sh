#!/bin/sh

max=`cat /sys/class/backlight/intel_backlight/max_brightness`
bars=`cat /sys/class/backlight/intel_backlight/brightness`

echo $max*100 $bars
