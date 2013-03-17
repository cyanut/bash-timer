#!/bin/bash

BIRed="\033[1;91m"
White="\033[0;37m"
BIWhite="\033[1;97m"

tstart=$(date --utc +%s)
strt=$1
tl=0
sc=${strt%%:*}
while [ "$strt" != "$sc" ]; do
    tl=$((tl * 60 + sc))
    strt=${strt#*:}
    sc=${strt%%:*}
done
tl=$(( tl * 60 + sc ))

ftstart=$(date "+%T")
tend=$(date --date "now $tl sec" "+%T")
deltat=0
while [ $tl -gt $deltat ]; do
    sleep 1
    tnow=$(date --utc +%s)
    deltat=$(( tnow - tstart ))
    tleft=$((tl - deltat))
    echo -n -e "-----" $BIWhite$(date --date "00:00:00 $tleft sec" "+%T")$White "seconds left -----  ($tl secs, $ftstart -> $tend)     \r"       
done

#commented out beeper sound
: <<'END'
(for ((i=0; i<5; i++)); do
    aplay beep/beat.wav || exit
done
for ((i=0; i<3; i++)); do
    aplay beep/flat.wav || exit
done
aplay beep/flat-end.wav || exit) &
END

t=0

for ((t=0;;t++)); do
    sleep 1
    echo -n -e "-----"$BIRed$(date --date "00:00:00 $t sec" "+%T") "seconds passed $White----- ($tl secs, $ftstart -> $tend)      \r"
done

