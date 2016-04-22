:global num value=1
:global total value=[:len [/interface pppoe-client find running]]
/ip firewall mangle remove [/ip firewall mangle find where comment~("pcc_")];
/ip firewall nat remove [/ip firewall nat find where comment~("pcc_")];
/ip route remove [/ip route find where  comment~("pcc_")]

/ip firewall mangle remove [/ip firewall mangle find where comment~("nth_")];
/ip firewall nat remove [/ip firewall nat find where comment~("nth_")];
/ip route remove [/ip route find where  comment~("nth_")]

:foreach i in=[/interface pppoe-client find running] do={
:set i value=[/interface pppoe-client get $i name];
/ip firewall mangle add action=mark-connection chain=prerouting comment=("pcc_conn_".$i) connection-state=new disabled=no new-connection-mark=("pcc_conn_".$i) per-connection-classifier=("both-addresses:" . ($total . "/" . ($num - 1))) passthrough=yes src-address=192.168.0.0/16 dst-address=!192.168.0.0/16;

/ip firewall mangle add action=mark-routing chain=prerouting comment=("pcc_rout_".$i) connection-mark=("pcc_conn_".$i) disabled=no new-routing-mark=("pcc_rout_".$i) passthrough=no src-address=192.168.0.0/16 dst-address=!192.168.0.0/16;

/ip firewall nat add action=masquerade chain=srcnat disabled=no out-interface=$i comment=("pcc_nat_".$i) src-address=192.168.0.0/16;

/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=$i routing-mark=("pcc_rout_".$i) scope=30 target-scope=10 comment=("pcc_route_".$i);
/ip route add disabled=no distance=1 dst-address=0.0.0.0/0 gateway=$i distance=2 scope=30 target-scope=0 comment=("pcc_route_".$i);
set num [:tonum {$num +1}]
}