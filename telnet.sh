#!/bin/bash

IPS=("192.168.56.x:300" "170.0.0.0:3000")

for entry in "${IPS[@]}"; do

IFS=':' read -r ip port <<< "$entry"

echo "Attempting to telnet to $ip on port $port..."

result=$(timeout 1 telnet $ip $port 2>&1 | grep -i "Connected")

if [[ -n "$result" ]]; then echo "Success $ip $port"

else

echo "Failed $ip $port"

fi

echo "----------------------------------"

done