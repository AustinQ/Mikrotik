{
:global oldip ;
/tool fetch url=http://1212.ip138.com/ic.asp keep-result=yes;
:local file [:pick [file get ic.asp ] 1];
:local currip [:pick $file 168 [:find $file "]"]];
if ($currip != $oldip) do={
	:log warning ([:len $oldip].[:len $currip]);
	/tool e-mail send server=[:resolve smtp.126.com] to=assss@126.com from=assss@126.com user=assss password=asdasdasd subject=([/system identity get name]." New IP address:".$currip) body="Have a good day!"
	:log warning ("Address Change:".$oldip."-->".$currip);
	:set oldip $currip;
	}
}
