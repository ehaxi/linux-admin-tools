#!/bin/bash
echo "==================== SYSTEM STATUS ===================="
echo

echo "System info"
hostnamectl
echo

echo "Uptime info"
uptime
echo

echo "CPU usage:"
mpstat -P ALL | grep -v "Linux" | tail
echo

echo "Memory usage:"
free | awk 'NR==1 {print "Used%\tFree%"} NR==2 {printf "%.1f%%\t%.1f%%\n", $3/$2*100, $4/$2*100}'
echo

echo "Disk usage (current dir):"
df ./ -h --output=size,used,avail,pcent
echo

echo "Top 5 processes by CPU usage:"
ps aux --sort=-%cpu | head -6 | awk '{print $1 "\t" $2 "\t" $3}'
echo

echo "Top 5 processes by memory usage:"
ps aux --sort=-%mem | head -6 | awk '{print $1 "\t" $2 "\t" $4}'
echo

echo "System temperature:"
sensors | awk 'NR==1 {printf "GPU temperature: "} NR==5 {print $2} NR==13 {printf "CPU temperature: "} NR==15 {print $2}'
echo

echo "======================================================="
