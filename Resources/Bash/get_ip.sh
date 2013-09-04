#!/bin/bash 
# print out the active interface connect to Internet
# print out the IP and gateway
# using several command like: route, ip route list

input=$(ip route ls)

gateway=$(echo $input | awk '{print $3}')
interface=$(echo $input | awk '{print $5}')
ip=$(echo $input | awk '{print $23}')


echo -e "interface: \t" $interface
echo -e "gateway is: \t" $gateway
echo -e "IP is: \t\t" $ip

# get from ifconfig -> can do not know what interface is active
#IP=`ifconfig  | grep 'inet addr:'| grep -v '127.0.0.1' | cut -d: -f2 | awk '{ print $1}'`

