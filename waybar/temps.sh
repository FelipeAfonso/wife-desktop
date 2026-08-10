#!/bin/bash
# hwmon indices shuffle across boots — resolve them by chip name.
for h in /sys/class/hwmon/hwmon*; do
  case "$(cat "$h/name")" in
    k10temp) cpu_hwmon=$h ;;
    amdgpu) gpu_hwmon=$h ;;
  esac
done

cpu=$(awk '{printf "%d", $1/1000}' "$cpu_hwmon/temp1_input")
gpu=$(awk '{printf "%d", $1/1000}' "$gpu_hwmon/temp1_input")

if [ "$cpu" -gt 90 ] || [ "$gpu" -gt 90 ]; then
  cls="critical"
else
  cls="normal"
fi

echo '{"text":" CPU '$cpu'°C GPU '$gpu'°C","tooltip":"CPU (Tctl): '$cpu'°C\rGPU (edge): '$gpu'°C","class":"'$cls'"}'
