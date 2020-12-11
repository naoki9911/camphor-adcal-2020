#!/bin/vbash
ip route del default

source /opt/vyatta/etc/functions/script-template
configure

set system host-name vyos-65002

# configure loopback
set interfaces loopback lo address 192.168.200.1/32

# configure VLAN interface
set interfaces ethernet eth0 vif 200 address 192.168.1.6/30
set interfaces ethernet eth0 vif 250 address 192.168.200.1/25

# configure static route
set protocols static route 0.0.0.0/0 next-hop 192.168.1.5

commit
exit