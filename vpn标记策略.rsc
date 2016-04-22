# apr/13/2016 16:42:07 by RouterOS 6.32.4
#
/ip firewall mangle
add action=mark-connection chain=prerouting comment="pcDuino DNS" dst-address-list=!novpn dst-port=53 new-connection-mark=vpn-conn protocol=tcp src-address=192.168.88.3
add action=mark-connection chain=prerouting comment="pcDuino DNS" dst-address-list=!novpn dst-port=53 new-connection-mark=vpn-conn protocol=udp src-address=192.168.88.3
add action=mark-connection chain=prerouting comment=pcDuino->VPN dst-address-list=vpn new-connection-mark=vpn-conn src-address=192.168.88.3
add action=mark-routing chain=prerouting comment="pcDuino Route" connection-mark=vpn-conn new-routing-mark=vpn-rout passthrough=no src-address=192.168.88.3


# 源:lan->目的:vpn 全部走VPN
add action=mark-connection chain=prerouting comment=lan->vpn dst-address=!192.168.0.0/16 dst-address-list=vpn new-connection-mark=vpn-conn src-address=192.168.0.0/16 src-address-list=!novpnclient
# 源:lan->目的:不是novpn(国外地址) 协议:icmp 走VPN
add action=mark-connection chain=prerouting comment="lan->any:tcp(1-1024)" dst-address=!192.168.0.0/16 dst-address-list=!novpn new-connection-mark=vpn-conn protocol=icmp src-address=192.168.0.0/16 src-address-list=!novpnclient
# 源:lan->目的:不是novpn(国外地址) 协议:tcp 端口号:1-1024 走VPN
add action=mark-connection chain=prerouting comment="lan->any:tcp(1-1024)" dst-address=!192.168.0.0/16 dst-address-list=!novpn dst-port=1-1024 new-connection-mark=vpn-conn protocol=tcp src-address=192.168.0.0/16 src-address-list=!novpnclient
# 源:lan->目的:不是novpn(国外地址) 协议:udp 端口号:1-1024 走VPN
add action=mark-connection chain=prerouting comment="lan->any:udp(1-79,81-1024)" dst-address=!192.168.0.0/16 dst-address-list=!novpn dst-port=1-79,81-1022 new-connection-mark=vpn-conn protocol=udp src-address=192.168.0.0/16 src-address-list=!novpnclient
# 源:特定主机(allinvpnclient)->目的:不是novpn(国外地址) 协议:全部 全部走VPN
add action=mark-connection chain=prerouting comment=all-vpn-conn dst-address=!192.168.0.0/16 dst-address-list=!vps new-connection-mark=vpn-conn src-address=192.168.0.0/16 src-address-list=allinvpnclient
add action=mark-routing chain=prerouting comment=vpn-route connection-mark=vpn-conn dst-address=!192.168.0.0/16 dst-address-list=!novpn new-routing-mark=vpn-rout passthrough=no src-address=192.168.0.0/16 src-address-list=!novpnclient
