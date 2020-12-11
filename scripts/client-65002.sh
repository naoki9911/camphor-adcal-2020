#!/bin/bash

# delete default route via docker network
ip route del default

# configure vlan
ip link add link eth0 name eth0.250 type vlan id 250
ip a add 192.168.200.2/25 dev eth0.250
ip link set dev eth0.250 up

# configure default route via vyos
ip route add default via 192.168.200.1

# wait for tty
while true
do
  sleep 1
done
