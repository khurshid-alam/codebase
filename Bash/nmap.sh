#!/bin/bash 
# Using nmap to scan the current network
# Default is normal scan
# Can get more option from $1 $2 $3

gateway=$(ip route ls | awk '{print $3}' | grep '^[0-9]')
nmap $1 $2 $3 $gateway/24
