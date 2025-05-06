#!/bin/bash

volume_info=$(pactl get-sink-volume @DEFAULT_SINK@)
left=$(echo "$volume_info" | grep -oP '\d+(?=%)' | sed -n '1p')
right=$(echo "$volume_info" | grep -oP '\d+(?=%)' | sed -n '2p')

avg=$(( (left + right) / 2 ))
echo -e "Volume $avg%"
