#!/bin/sh

# This script displays battery icon according to the charge level and charging state

# Author: Piotr Miller
# e-mail: nwg.piotr@gmail.com
# Website: http://nwg.pl
# Project: https://github.com/nwg-piotr/tint2-executors
# License: GPL3

# Dependencies: `acpi`

bats=$(acpi -b)
while IFS= read -r line; do
    if [[ $line == *unavailable* ]]; then
        continue
    fi
    bat=$line
    state=$(echo ${bat} | awk '{print $3}')

    if [[ "$state" = "Not" ]]; then
        level=$(echo ${bat} | awk '{print $5}')
        level=${level::-1}
    else
        level=$(echo ${bat} | awk '{print $4}')
        if [[ "$state" == *"Unknown"* ]]; then
            level=${level::-1}
        else
            level=${level::-2}
        fi
    fi

    if [[ "$bat" == *"until"* ]]; then

        if [[ "$level" -ge "95" ]]; then
            echo .config/tint2/images/bat-full-charging.svg
        elif [[ "$level" -ge "75" ]]; then
            echo .config/tint2/images/bat-threefourth-charging.svg
        elif [[ "$level" -ge "35" ]]; then
            echo .config/tint2/images/bat-half-charging.svg
        elif [[ "$level" -ge "15" ]]; then
            echo .config/tint2/images/bat-quarter-charging.svg
        else
            echo .config/tint2/images/bat-empty-charging.svg
        fi
    else
        if [[ "$level" -ge "95" ]]; then
            echo .config/tint2/images/bat-full.svg
        elif [[ "$level" -ge "75" ]]; then
            echo .config/tint2/images/bat-threefourth.svg
        elif [[ "$level" -ge "35" ]]; then
            echo .config/tint2/images/bat-half.svg
        elif [[ "$level" -ge "15" ]]; then
            echo .config/tint2/images/bat-quarter.svg
        else
            echo .config/tint2/images/bat-empty.svg
        fi
    fi
    if  [[ $1 = "-l" ]]; then
        time=$(echo ${bat} | awk '{print $5}')
        hh=${time:0:2}
        mm=${time:3:2}
        if [[ "$hh" -eq "00" ]]; then
            time="${mm} minutes"
        else
            time="${hh}:${mm}"
        fi
        echo ${level}%, ${time}, $(date +"%a %d %b %H:%M")
    fi
done <<< "$bats"
