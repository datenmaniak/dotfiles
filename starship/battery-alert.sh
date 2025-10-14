#!/usr/bin/zsh


battery_level=$(cat /sys/class/power_supply/BAT0/capacity)

if [ "$battery_level" -lt 15 ]; then
  export STARSHIP_BATTERY_ALERT="low"
else
  export STARSHIP_BATTERY_ALERT="ok"
fi


echo -e "Watch on battery"
echo "Battery script ejecutado: $(date)" >> /tmp/battery.log
