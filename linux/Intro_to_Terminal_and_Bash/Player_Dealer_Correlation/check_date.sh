#!/bin/bash

DATE="${@}"

function check_date() {
    local re='(0[0-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])'
    echo "Checking the date input ${TIME}"
    local len=${#DATE}
    echo $len
    if [ $len -eq 4 ] && [[ "${DATE}" =~ $re ]]; then
        echo "date string has correct format"
    else
        echo "Invalid date format."
        exit 1
    fi
}

check_date "${DATE}"
exit 0
