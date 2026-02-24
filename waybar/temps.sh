#!/bin/bash
cpu=$(awk '{printf "%d", $1/1000}' /sys/class/hwmon/hwmon2/temp1_input)
gpu=$(awk '{printf "%d", $1/1000}' /sys/class/hwmon/hwmon5/temp1_input)

if [ "$cpu" -gt 90 ] || [ "$gpu" -gt 90 ]; then
  cls="critical"
else
  cls="normal"
fi

echo '{"text":" CPU '$cpu'°C GPU '$gpu'°C","tooltip":"CPU (Tctl): '$cpu'°C\rGPU (edge): '$gpu'°C","class":"'$cls'"}'
