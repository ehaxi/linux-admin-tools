#!/bin/bash

if [[ $# -ne 1 ]]; then
    echo "Usage: ./nginx-log-analyzer.sh <logs_file>"
    exit 1
fi

file=$1 

echo "Top 5 IP addresses with the most requests:"
awk '{print $1}' "${file}" | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "IP: %-15s Count: %s\n", $2, $1}'
echo

echo "Top 5 most requested paths:"
awk '{print $7}' "${file}" | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "Requested Path: %-25s Count: %s\n", $2, $1}'
echo

echo "Top 5 response status codes:"
awk '{print $9}' "${file}" | sort | uniq -c | sort -nr | head -n 5 | awk '{printf "Status Code: %-4s Count: %s\n", $2, $1}'
echo

echo "Top 5 user agents:"
awk -F'"' '{count[$(NF-1)]++} END {for (ua in count) print count[ua], ua}' "${file}" | sort -nr | head -n 5 | while read count user_agent; do
    printf "User Agent: %-120s Count: %s\n" "$user_agent" "$count"
done