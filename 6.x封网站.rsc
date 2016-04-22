:set $QQSTR "qq,baidu";
:set $QQLST "Q-DST"
:set $id [/ip dns cache all find type=A]
:foreach i in=$id do={
	:set $dom [/ip dns cache all get $i name]
	:set $found "no"
	:foreach k in=[:toarray $QQSTR] do={
		:if ([:find $dom $k] >= 0) do={
			:set $found "yes"
		}
	}
	:if ($found="yes") do={
		:log error ($dom,[/ip dns cache all get $i data])
		if ([:len [/ip firewall address-list find  where address=[/ip dns cache all get $i data] list=$QQLST]] < 0) do={ 
			/ip firewall address-list add list=$QQLST disabled=no address=[/ip dns cache all get $i data] comment=$dom
			}
		}
}

/ip dns cache flush
