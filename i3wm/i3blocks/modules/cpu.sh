#!/bin/bash

# Get CPU usage from top
cpu_usage=$(top -bn1 | grep "Cpu(s)" | awk '{print $2 + $4}' | tr -d '%')

# Output the CPU usage with a label
if [ -n "$cpu_usage" ]; then
    echo "CPU: $cpu_usage%"
else
    echo "CPU: N/A"
fi

# Uncomment the following line to update the module every second
 echo -e "\0icon\x1fsystem\x0f\x0b#FFFF00\x0b"