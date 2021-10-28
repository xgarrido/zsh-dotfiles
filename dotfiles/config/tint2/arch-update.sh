#!/bin/bash

# Author: Piotr Miller
# e-mail: nwg.piotr@gmail.com
# Website: http://nwg.pl
# Project: https://github.com/nwg-piotr/tint2-executors
# License: GPL3

# Credits: RaphaelRochet/arch-update
# https://github.com/RaphaelRochet/arch-update
# Icon by @edskeye

upd=$(/bin/sh -c "/usr/bin/checkupdates")

if [[ ! -z "$upd" ]]
then
    nbr_packages=$(echo "$upd" | wc -l)
    echo ~/.config/tint2/images/arch-icon-notify.svg
    echo "$nbr_packages"
    if [[ ${nbr_packages} -gt 2 ]]; then
        upd="$(echo "$upd" | head -n2)\nand $(( ${nbr_packages} - 2 )) others packages"
    fi
    notify-send "Pending updates:" "$upd" --icon="archlinux" --expire-time=5000
else
    echo ~/.config/tint2/images/arch-icon.svg
fi
