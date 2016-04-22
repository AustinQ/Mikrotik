:global num value=1
:global total value=[:len [/interface pppoe-client find running]]
/ip firewall mangle remove [/ip firewall mangle find where comment~("nth_")];
/ip firewall nat remove [/ip firewall nat find where comment~("nth_")];
/ip route remove [/ip route find where  comment~("nth_")]

:foreach i in=[/interface pppoe-client find running] do={
:set i value=[/interface pppoe-client get $i name];
/ip firewall mangle add action=mark-connection chain=prerouting comment=("nth_conn_".$i) connection-state=new disabled=no new-connection-mark=("conn_".$i) nth=($total.",".$num) passthrough=yes src-address=192.168.0.0/16 dst-address=!192.168.0.0/16;
/ip firewall mangle add action=mark-routing chain=prerouting comment=("nth_rout_".$i) connection-mark=("conn_".$i) disabled=no new-routing-mark=("rout_".$i) passthrough=yes src-address=192.168.0.0/16 dst-address=!192.168.0.0/16;

/ip firewall nat add action=masquerade chain=srcnat disabled=no out-interface=$i comment=("nth_nat_".$i) src-address=192.168.0.0/16;

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=$i routing-mark=("rout_".$i) scope=30 target-scope=10 comment=("nth_route_".$i);
/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=$i scope=30 target-scope=0 comment=("nth_route_".$i);
set num [:tonum {$num +1}]
}