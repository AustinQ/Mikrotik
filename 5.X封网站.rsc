:local QQSTR "qq,baidu,shifen";
:local QQLST "deny_site";
:local id [/ip dns cache all find type="A"];
:foreach i in=$id do={;
 :local dom [/ip dns cache all get $i name];
 :local found "no";
 :foreach k in=[:toarray $QQSTR] do={
  :if ([:find $dom $k] >= 0) do={
   :set found "yes";
  }
  :log war $found;
 }
 :if ($found="true") do={
  :log error ($dom,[/ip dns cache all get $i data]);
  if ([:len [/ip firewall address-list find  where address=[/ip dns cache all get $i data] list=$QQLST]] < 0) do={ 
   /ip firewall address-list add list=$QQLST disabled=no address=[/ip dns cache all get $i data] comment=$dom
   }
  }
}
