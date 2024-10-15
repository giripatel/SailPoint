#!/bin/bash

# Define an array of IP:PORT combinations
IPS=("192.168.1.1:23" "192.168.1.2:8080" "192.168.1.3:1234")

# Loop through each IP:PORT
for entry in "${IPS[@]}"
do
  # Split the entry into IP and PORT
  IFS=':' read -r ip port <<< "$entry"

  echo "Attempting to telnet to $ip on port $port..."
  
  # Use telnet with a timeout, redirect stderr to stdout, and grep for known success pattern
  result=$(timeout 5 telnet $ip $port 2>&1 | grep -i "Connected")

  if [ -n "$result" ]; then
    echo "Successfully connected to $ip on port $port"
  else
    echo "Failed to connect to $ip on port $port"
  fi

  echo "-------------------------"
done
