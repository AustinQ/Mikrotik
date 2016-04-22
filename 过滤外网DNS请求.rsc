# BY Q
/ip firewall filter
add action=drop chain=input comment=Deny_WAN->Local:53 dst-port=53 protocol=udp src-address=!192.168.0.0/16
