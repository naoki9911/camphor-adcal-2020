#!/bin/vbash
ip route del default

source /opt/vyatta/etc/functions/script-template
configure

set system host-name vyos-65003

# configure loopback
set interfaces loopback lo address 192.168.250.1/32

# configure VLAN interface
set interfaces ethernet eth0 vif 103 address 192.168.250.1/30
set interfaces ethernet eth0 vif 203 address 192.168.250.5/30

# configure latency emulation policy
set traffic-policy network-emulator DELAY-3 network-delay 3
set interfaces ethernet eth0 vif 103 traffic-policy out DELAY-3
set interfaces ethernet eth0 vif 203 traffic-policy out DELAY-3

# configure BGP
set protocols bgp 65003 address-family ipv4-unicast network 192.168.250.0/24

# configure BGP neighbor
set protocols bgp 65003 neighbor 192.168.250.2 remote-as 65001
set protocols bgp 65003 neighbor 192.168.250.2 address-family ipv4-unicast nexthop-self

set protocols bgp 65003 neighbor 192.168.250.6 remote-as 65002
set protocols bgp 65003 neighbor 192.168.250.6 address-family ipv4-unicast nexthop-self

commit
exit
