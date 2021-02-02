#!/bin/bash

# This script prints system information. Must be run from a linux machine. #
echo "System Info - `date +%A", "%B" "%d`"
echo "Uname = `uname -ros`"
echo "IP Address = `ip addr | grep "inet 10" | awk -F' ' {'print $2'}`"
echo "Hostname = $HOSTNAME"
