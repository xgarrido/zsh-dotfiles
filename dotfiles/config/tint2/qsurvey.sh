#!/bin/bash

# Get number of jobs running, waiting and anything else
cmd="SGE_ROOT=/opt/sge SGE_CELL=ccin2p3 /opt/sge/bin/lx-amd64/qstat"
new_status=$(ssh garrido@cca.in2p3.fr ${cmd} | tail -n +3 |
             awk 'BEGIN{r=qw=0} $5 == "r" {r++} $5 ~ "qw" {qw++} END{print r"|"qw"|"NR - (r + qw)}')
log_status=/tmp/qsurvey_status.log
old_status=$(cat ${log_status})
echo ${new_status} > ${log_status}

if [[ ${old_status} != ${new_status} ]]; then
    old=(${old_status//|/ })
    new=(${new_status//|/ })
    if [[ ${old[0]} < ${new[0]} ]]; then
        notify-send -i gtk-info "qsurvey" "$(( ${new[0]} - ${old[0]} )) jobs started @ CC-IN2P3"
    fi
    if [[ ${old[0]} > ${new[0]} ]]; then
        notify-send -i gtk-info "qsurvey" "$(( ${old[0]} - ${new[0]} )) jobs stopped @ CC-IN2P3"
    fi
fi

# Generate svg status icon
opacity=1
if [[ ${new_status} == "0|0|0" ]]; then
    opacity=0
    new_status=""
fi
icon_svg="<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 16 16\">
 <path style=\"fill:#ececec;fill-opacity:1;stroke:none;fill-rule:evenodd\" d=\"m 14.735 8.563 c -0.002 0 -0.003 0 -0.005 0 l -0.002 0 c -0.618 0 -1.531 -0.367 -1.995 -0.802 -0.014 -0.013 -0.029 -0.027 -0.043 -0.042 c -0.101 -0.099 -0.211 -0.224 -0.328 -0.364 -0.143 -0.171 -0.295 -0.366 -0.452 -0.567 -0.639 -0.817 -1.243 -1.588 -1.765 -1.588 c -0.371 0 -0.799 0.208 -1.213 0.41 -0.344 0.168 -0.701 0.342 -0.932 0.342 -0.232 0 -0.588 -0.174 -0.932 -0.342 c -0.414 -0.202 -0.841 -0.41 -1.213 -0.41 -0.522 0 -1.126 0.772 -1.765 1.588 -0.119 0.152 -0.235 0.301 -0.347 0.439 -0.36 0.495 -0.845 0.848 -1.313 1.055 -0.393 0.171 -0.82 0.281 -1.157 0.281 c -0.229 0 -0.319 -0.054 -0.342 -0.071 -0.156 -0.116 -0.307 -0.175 -0.45 -0.175 -0.202 0 -0.372 0.127 -0.444 0.331 -0.089 0.252 -0.015 0.561 0.198 0.828 0.613 0.767 1.946 1.236 3.699 1.313 0.169 0.007 0.341 0.011 0.517 0.011 0.014 0 0.029 0 0.043 0 c 1.301 -0.018 2.472 -0.841 3.139 -1.612 0.137 -0.158 0.315 -0.166 0.349 -0.166 l 0.001 0 0.006 0.003 0.024 -0.003 0.004 0 c 0.034 0 0.213 0.008 0.349 0.166 0.657 0.76 1.804 1.571 3.082 1.611 0.033 0.001 0.066 0.002 0.099 0.002 0.322 0 0.632 -0.012 0.928 -0.037 1.55 -0.127 2.723 -0.581 3.288 -1.287 0.213 -0.266 0.287 -0.576 0.198 -0.828 -0.072 -0.204 -0.242 -0.331 -0.444 -0.331 -0.142 0 -0.294 0.059 -0.45 0.175 -0.022 0.016 -0.111 0.07 -0.335 0.071 z\"/>
 <path d=\"m 15.273 8 c 0 0.902 -0.723 1.637 -1.617 1.637 -0.891 0 -1.617 -0.734 -1.617 -1.637 0
          -0.902 0.727 -1.637 1.617 -1.637 0.895 0 1.617 0.734 1.617 1.637 z\"
       style=\"fill:#ef555c;fill-opacity:${opacity}\" transform=\"translate(-1, -5)\"/>
</svg>"
echo ${icon_svg} > /tmp/qsurvey.svg

# Print icon/info into tint
echo "/tmp/qsurvey.svg"
echo ${new_status}
