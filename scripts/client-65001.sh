#!/bin/bash

# delete default route via docker network
ip route del default

# configure vlan
ip link add link eth0 name eth0.150 type vlan id 150
ip a add 192.168.100.2/25 dev eth0.150
ip link set dev eth0.150 up

# configure default route via vyos
ip route add default via 192.168.100.1

# wait for tty
while true
do
  sleep 1
done
