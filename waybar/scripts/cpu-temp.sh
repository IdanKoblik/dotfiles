#!/usr/bin/env bash

model=$(awk -F ': ' '/model name/{print $2}' /proc/cpuinfo | head -n 1 | sed 's/@.*//; s/ *\((R)\|(TM)\)//g; s/^[ \t]*//; s/[ \t]*$//')

# get CPU clock speeds
get_cpu_frequency() {
  freqlist=$(awk '/cpu MHz/ {print $4}' /proc/cpuinfo)
  maxfreq=$(sed 's/...$//' /sys/devices/system/cpu/cpu0/cpufreq/cpuinfo_max_freq)
  if [ -z "$freqlist" ] || [ -z "$maxfreq" ]; then
    echo "--"
    return
  fi
  average_freq=$(echo "$freqlist" | tr ' ' '\n' | awk "{sum+=\$1} END {printf \"%.0f/%s MHz\", sum/NR, $maxfreq}")
  echo "$average_freq"
}

get_cpu_temperature() {
  raw_temp=$(cat /sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input 2>/dev/null)
  if [[ -z "$raw_temp" ]]; then
    echo "--"
    return
  fi
  temp=$(awk "BEGIN {printf \"%.0f\", $raw_temp / 1000}")
  echo "$temp"
}

get_temperature_icon() {
  temp_value=$1
  if [ "$temp_value" = "--" ]; then
    icon="󱔱" # none
  elif [ "$temp_value" -ge 80 ]; then
    icon="󰸁" # high
  elif [ "$temp_value" -ge 70 ]; then
    icon="󱃂" # medium
  elif [ "$temp_value" -ge 60 ]; then
    icon="󰔏" # normal
  else
    icon="󱃃" # low
  fi
  echo "$icon"
}

cpu_frequency=$(get_cpu_frequency)
read -r temp_info < <(get_cpu_temperature)
temp=$(echo "$temp_info" | awk '{print $1}')
temp_f=$(echo "$temp_info" | awk '{print $2}')
thermo_icon=$(get_temperature_icon "$temp")

# high temp warning
if [ "$temp" == "--" ] || [ "$temp" -ge 80 ]; then
  text_output="<span color='#f38ba8'>${thermo_icon} ${temp}°C</span>"
else
  text_output="${thermo_icon} ${temp}°C"
fi

tooltip=":: ${model}\n"
tooltip+="Clock Speed: ${cpu_frequency}\nTemperature: ${temp_f}°F"

# module and tooltip
echo "{\"text\": \"$text_output\", \"tooltip\": \"$tooltip\"}"
