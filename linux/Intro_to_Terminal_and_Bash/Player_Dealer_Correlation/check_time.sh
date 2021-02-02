#!/bin/bash

TIME="${@}"

function check_time() {
    local re='(0[0-9]|1[0-2])([AaPp][Mm])'
    echo "Checking the time input ${TIME}"
    local len=${#TIME}
    echo $len
    if [ $len -eq 4 ] && [[ "${TIME}" =~ $re ]]; then
        echo "time string has correct format"
        echo ${BASH_REMATCH[1]}
        echo ${BASH_REMATCH[2]}
    else
        echo "Invalid time format."
        exit 1
    fi
}

check_time "$TIME"
exit 0
