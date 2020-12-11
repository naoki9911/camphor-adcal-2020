#!/bin/vbash
source /opt/vyatta/etc/functions/script-template
configure

# configure hostname
set system host-name vyos-internet

# configure VLAN interface
set interfaces ethernet eth0 vif 100 address 192.168.1.1/30
set interfaces ethernet eth0 vif 200 address 192.168.1.5/30

# configure latency emulation policy
set traffic-policy network-emulator DELAY-8 network-delay 8
set interfaces ethernet eth0 vif 100 traffic-policy out DELAY-8
set interfaces ethernet eth0 vif 200 traffic-policy out DELAY-8

# configure static route to each vyos
set protocols static route 192.168.100.0/24 next-hop 192.168.1.2
set protocols static route 192.168.200.0/24 next-hop 192.168.1.6

# 環境によって変えること
set protocols static route 0.0.0.0/0 next-hop 172.19.0.1

# configure nat
set nat source rule 1001 outbound-interface eth0
set nat source rule 1001 source address 192.168.100.0/24
set nat source rule 1001 translation address masquerade
set nat source rule 1002 outbound-interface eth0
set nat source rule 1002 source address 192.168.200.0/24
set nat source rule 1002 translation address masquerade

commit
exit
