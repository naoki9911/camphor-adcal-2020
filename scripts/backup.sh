#!/bin/vbash
source /opt/vyatta/etc/functions/script-template
configure

set system host-name vyos-65001-0

# configure loopback
set interfaces loopback lo address 192.168.101.1/32

# configure VLAN interface
set interfaces ethernet eth0 vif 10 address 192.168.100.2/30

# configure BGP
set protocols bgp 65001 address-family ipv4-unicast network 192.168.101.0/24

# configure neighbor
set protocols bgp 65001 neighbor 192.168.100.1 remote-as 65000

commit
exit
