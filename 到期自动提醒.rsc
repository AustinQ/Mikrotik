  :global today
  :global endday
  :global date
  :local montharray ( "jan","feb","mar","apr","may","jun","jul","aug","sep","oct","nov","dec" )
  :local monthdays ( 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 )

  :set date [ /system clock get date ]
  :local days [ :pick $date 4 6 ]
  :local monthtxt [ :pick $date 0 3 ]
  :local year [ :pick $date 7 11 ]
  :local months ([ :find $montharray $monthtxt]  )
  :for nodays from=0 to=$months do={
   :set days ( $days + [ :pick $monthdays $nodays ] )
  }
  :set days ($days + $year * 365) 
  :set today $days

 foreach  i in=[/ppp secret find where profile=allinvpn-server] do={
  :local last [/ppp secret get [/ppp secret get $i name] last-logged-out ];
  :local lastdate [:pick $last 0 ([:len $last]-9)];
  :set date $lastdate 

  :local days [ :pick $date 4 6 ]
  :local monthtxt [ :pick $date 0 3 ]
  :local year [ :pick $date 7 11 ]
  :local months ([ :find $montharray $monthtxt]  )
  :for nodays from=0 to=$months do={
   :set days ( $days + [ :pick $monthdays $nodays ] )
  }
  :set days ($days + $year * 365) 

  :set endday $days
  if (($today-$endday)>15) do={:log err ([/ppp secret get $i name]." expire!")}
 }