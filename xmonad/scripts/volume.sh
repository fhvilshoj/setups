#!/bin/sh
res="Vol: "
mute=`(pactl list sinks | grep "Mute:")| awk '{i++}i==2{print $2}'`
vol=`(pactl list sinks | grep "Volume: 0:")| awk '{i++}i==2{print $3}'`
if [ "$mute" = "yes" ]; then
  res+="Mute"
else
  res+=$vol
fi
echo $res
