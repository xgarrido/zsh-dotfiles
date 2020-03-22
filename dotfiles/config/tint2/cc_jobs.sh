#!/bin/sh

# This script displays jobs at CC

# Author: Xavier Garrido
# e-mail: xavier.garrido@gmail.com
# License: GPL3

# Dependencies: `qsurvey`

nbr_running=0
nbr_pending=0
nbr_stopped=0
logfile="/tmp/qsurvey.log"
if [ ! -f ${logfile} ]; then
    echo -ne "<span foreground='#5294E2' weight='bold' size='x-large' rise='4000'></span><span rise='6000'>    qsurvey program not running</span>"
    exit 1
else

    user="$1"
    top_line=$(cat ${logfile} | head -n1)
    tail_line=$(cat ${logfile} | tail -n1)
    if $(echo ${top_line} | grep ${user} > /dev/null); then
        nbr_running=$(echo ${top_line} | sed 's/.*'${user}'.*: \([0-9]*\).*/\1/')
    fi
    if $(echo ${tail_line} | grep ${user} > /dev/null); then
        nbr_pending=$(echo ${tail_line} | sed 's/.*'${user}'.*: \([0-9]*\).*/\1/')
    fi
    nbr_running=$(( nbr_running - nbr_pending))
fi
#:#dc322f:#859900:#b58900

echo -ne "<span foreground='#859900' weight='bold' size='x-large'></span> ${nbr_running} "
echo -ne "<span foreground='#b58900' weight='bold' size='x-large'></span> ${nbr_pending} "
echo -ne "<span foreground='#DC322F' weight='bold' size='x-large'></span> <span rise='0'>${nbr_stopped}</span> "
