:local ip [/ip address get [/ip address find interface=[/ip route get [/ip route find where distance=2 active] gateway ]] address ];
:local currip [:pick $ip  0 ([:len $ip]-3)];
:local oldip [:resolve www.yourdomain.com server=8.8.8.8];
if ($currip != $oldip) do={	
	#更新脚本;
	:log warning ("Address Change:".$oldip."-->".$currip);
} else={
	# :log info "Address Not Change";
}