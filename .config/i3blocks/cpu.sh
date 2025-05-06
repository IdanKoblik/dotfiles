temp=$(cat /sys/devices/platform/coretemp.0/hwmon/hwmon5/temp1_input)
echo -e "CPU ${temp:0:2} °C"
