########## PiNG THiNGiE 1.01+mc.anti_hack ############
#        designed and programmed by FlyBoyUSA        #
#        for original use in #emuroms Undernet       #
######################################################
# Bug reports and ideas goto flyboyus@modex.com
# I love comments, complaints, death threats, and suggestions :-)
# 
# Changes for 1.01+mc.anti_hack
#  MC_8 - BlkDrgon - Script no longer hackable via CTCP Reply.
#
# Changes for 1.01
# - changed syntax part
#

bind pub - !ping ping_me
bind pub - ping ping_me
bind ctcr - PING ping_me_reply

proc ping_me {nick uhost hand chan arg} {
     global pingchan pingwho
     set arg [string toupper $arg]
     if {$arg == "" || [string match "#*" $arg]} {
          puthelp "NOTICE $nick :Usage: ping <nick or me to have it ping you>"
          return 0
     } elseif {$arg == "ME"} {
          putserv "PRIVMSG $nick :\001PING [clock seconds]\001"
          set pingwho 0
          return 1
     } else { 
          putserv "PRIVMSG $arg :\001PING [clock seconds]\001"
          set pingwho 1
          set pingchan $chan
          return 1
     }
}

proc ping_me_reply {nick uhost hand dest key arg} {
 global pingchan pingwho
 if {[regexp -- {[^0-9]} $arg]} {
  putlog "PiNG THiNGiE:  Invalid ping reply from $nick, possible hack attempt: $arg"
 } else {
  if {$pingwho == 0} {
   puthelp "NOTICE $nick :\002PiNG THiNGiE\002 - Your ping reply took \002[duration [expr [clock seconds] - $arg]]\002"
  } elseif {$pingwho == 1} {
   puthelp "PRIVMSG $pingchan :\002PiNG THiNGiE\002 - $nick's ping reply took \002[duration [expr [clock seconds] - $arg]]\002"
  }
 }; return 0
}

putlog "=__ PiNG THiNGiE 1.01+mc.anti_hack by FlyBoyUSA Loaded __="
