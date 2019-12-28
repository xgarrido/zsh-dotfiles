#!/bin/bash

summary=$(echo -e "$2")
body=$(echo -e "$3" | sed '/play.google.com/d')

DISPLAY=:0 notify-send " $summary" "$body" -u low
