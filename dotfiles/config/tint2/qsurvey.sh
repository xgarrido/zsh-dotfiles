#!/bin/bash

# Check connectivty
error_svg=""
ssh_connect=$(ssh garrido@cca.in2p3.fr echo)
if [ $? -ne 0 ]; then
    error_svg="<path d=\"m 8 12 c 0 2.209 -1.791 4 -4 4 -2.209 0 -4 -1.791 -4 -4 0 -2.209 1.791 -4 4 -4 2.209 0 4 1.791 4 4\" style=\"fill:#dc322f;fill-opacity:1;fill-rule:evenodd\"/>
     <path d=\"m 3 9 2 0 0 3 -2 0 0 -3\" style=\"fill:#fff;fill-opacity:0.902\"/>
      <path d=\"m 3 14 c 0 -0.551 0.449 -1 1 -1 0.551 0 1 0.449 1 1 0 0.551 -0.449 1 -1 1 -0.551 0 -1 -0.449 -1 -1 z\" style=\"fill:#fff;fill-opacity:0.902;fill-rule:evenodd\"/>"
fi

# Get number of jobs running, waiting and anything else
cmd="SGE_ROOT=/opt/sge SGE_CELL=ccin2p3 /opt/sge/bin/lx-amd64/qstat"
new_status=$(ssh garrido@cca.in2p3.fr ${cmd} | tail -n +3 |
                 awk 'BEGIN{r=qw=0} $5 == "r" {r++} $5 ~ "qw" {qw++} END{print r"/"qw"/"NR - (r + qw)}')
log_status=/tmp/qsurvey_status.log
test -f ${log_status} && old_status=$(cat ${log_status}) || old_status="0/0/0"
echo ${new_status} > ${log_status}

if [[ ${old_status} != ${new_status} ]]; then
    old=(${old_status//\// })
    new=(${new_status//\// })
    if [[ ${old[0]} < ${new[0]} ]]; then
        notify-send -i gnome-todo "qsurvey" "$(( ${new[0]} - ${old[0]} )) jobs started @ CC-IN2P3"
    fi
    if [[ ${old[0]} > ${new[0]} ]]; then
        notify-send -i gnome-todo "qsurvey" "$(( ${old[0]} - ${new[0]} )) jobs stopped @ CC-IN2P3"
    fi
    if [[ ${new[1]} > 0 ]]; then
        notify-send -i gnome-todo "qsurvey" "${new[1]} jobs currently waiting @ CC-IN2P3"
    fi
fi

# Generate svg status icon
opacity=1
if [[ ${new_status} == "0/0/0" ]]; then
    opacity=0.1
    new_status=""
fi
icon_svg="<svg xmlns=\"http://www.w3.org/2000/svg\" viewBox=\"0 0 16 16\">
 <path d=\"m 2 1 c -1.108 0 -2 0.892 -2 2 l 0 9.999 c 0 1.108 0.892 2 2 2 l 11.999 0 c 1.108 0 2 -0.892 2 -2 l 0 -9.999 c 0 -1.108 -0.892 -2 -2 -2 z m 9.03 2 c 0.055 0.006 0.136 0.036 0.187 0.062 l 1.562 0.781 c 0.208 0.106 0.269 0.367 0.157 0.562 l -4.874 8.374 c -0.087 0.148 -0.268 0.239 -0.437 0.219 -0.052 -0.005 -0.107 -0.007 -0.157 -0.032 c -0.005 -0.003 -4.25 -3.312 -4.25 -3.312 -0.208 -0.106 -0.269 -0.367 -0.157 -0.562 l 1.031 -1.25 c 0.113 -0.195 0.386 -0.263 0.594 -0.157 l 2.313 1.75 3.624 -6.218 c 0.085 -0.146 0.241 -0.235 0.406 -0.219\" style=\"visibility:visible;fill:#ececec;opacity:${opacity};fill-opacity:1;stroke:none;display:inline;fill-rule:nonzero\"/>
 ${error_svg}
</svg>"
echo ${icon_svg} > /tmp/qsurvey.svg

# Print icon/info into tint
echo "/tmp/qsurvey.svg"
echo ${new_status}
