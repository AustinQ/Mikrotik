# BY Q
# 2016-04-21
/interface wireless access-list add vlan-mode=no-tag comment=Allow-ALL
/system scheduler
add interval=1m name=band-select on-event="foreach regid in=[/interface wireless registration-table find where uptime<1m] do={\r\
    \n :local mac [/interface wireless registration-table get \$regid mac-address];\r\
    \n if ([:len ([/interface wireless access-list find where mac-address=\$mac disabled=no])]=0) do={\r\
    \n  /interface wireless access-list add mac-address=\$mac authentication=no place-before=0;\r\
    \n  /system scheduler add name=(\"permit:\".\$mac) on-event=\"/interface wireless access-list set [/interface wireless access-list find mac-address=\$mac] authentication=yes comment=1;/system schedule\
    r remove permit:\$mac;\" interval=00:00:05;\r\
    \n  /system scheduler add name=(\"check:\".\$mac) on-event=\":local acl [/interface wireless access-list find where mac-address=\$mac];if ([:len [/interface wireless registration-table find where mac-\
    address=\$mac]]>0) do={/interface wireless access-list set comment=2.4G-Only \\\$acl;} else={/interface wireless access-list set comment=5.8G-Only authentication=no \\\$acl;};/system scheduler remove \
    check:\$mac;\" interval=00:00:40;\r\
    \n  }\r\
    \n }\r\
    \n" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive start-time=startup