#!/bin/vbash
ip route del default

source /opt/vyatta/etc/functions/script-template
configure

set system host-name vyos-65001

# configure loopback
set interfaces loopback lo address 192.168.100.1/32

# configure VLAN interface
set interfaces ethernet eth0 vif 100 address 192.168.1.2/30
set interfaces ethernet eth0 vif 150 address 192.168.100.1/25
set interfaces ethernet eth0 vif 103 address 192.168.250.2/30

commit

# configure static route
set protocols static route 0.0.0.0/0 next-hop 192.168.1.1

# configure BGP
set protocols bgp 65001 address-family ipv4-unicast network 192.168.100.0/24

# configure BGP neighbor
set protocols bgp 65001 neighbor 192.168.250.1 remote-as 65003

commit
exit
