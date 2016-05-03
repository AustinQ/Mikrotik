/tool netwatch
add down-script="/system scheduler\r\
    \nadd interval=10s name=schedule1 on-event=\"/interface wireless registration-table remove 0;\\r\\\r\
    \n    \\n/log info \\\"test\\\"\" policy=ftp,reboot,read,write,policy,test,password,sniff,sensitive start-time=startup\r\
    \n" host=192.168.88.1 interval=10s up-script="/system scheduler remove numbers=schedule1 "
