# Mikrotik
   MIkrotik Script

##5.X封网站&6.x封网站
    根据关键字查找网站A记录加入ip地址列表

##AutoNth5.26(+&-)
    自动Nth :5.26+:Ros5.26以上版本,5.26-:Ros5.26以下版本,
##AutoPCC  
    自动PCC 
##band-select
    自动判断无线客户端是否支持5G信号,如果支持5G禁用客户端的2.4G连接
##vpn标记策略
    源:lan->目的:vpn 全部走VPN
    源:lan->目的:不是novpn(国外地址) 协议:icmp 走VPN
    源:lan->目的:不是novpn(国外地址) 协议:tcp 端口号:1-1024 走VPN
    源:lan->目的:不是novpn(国外地址) 协议:udp 端口号:1-1024 走VPN
    源:特定主机(allinvpnclient)->目的:不是novpn(国外地址) 协议:全部 全部走VPN
##到期自动提醒
    用户15天没登录自动提醒

##过滤外网DNS请求
    Ros开启DNS转发,禁用外网IP UDP 53号端口

##DDNS##
    判断外网IP和域名是否相同,不相同更新DDNS

##IP变更自动发送邮件更新.rsc##
 通过IP138获取当前出口IP 和之前IP做对比,如果不相同 发送邮件给特定邮箱