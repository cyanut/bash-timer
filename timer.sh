#!/bin/bash

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

for ((i=0; i<5; i++)); do
    aplay beep/beat.wav || exit
done
for ((i=0; i<3; i++)); do
    aplay beep/flat.wav || exit
done
aplay beep/flat-end.wav || exit
