#!/bin/bash
#title                      :dealer_finder_by_time_and_game.sh
#description                :This script will search for the dealer for a specified game on a specified time and date
#author                     :Mike Wong - michael.k.wong910@gmail.com
#date                       :11/08/20
#version                    :0.1
#usage                      :bash dealer_finder_by_time_and_game.sh -t [TIME] -d [DATE] -g [GAME]
#bash_version               :3.2.57(1)-release
#notes                      :Tested on macOS and Linux
#                           :Some of getopts code based on answers to Stack Overflow question: 
#                           :   https://stackoverflow.com/questions/5474732/how-can-i-add-a-help-method-to-a-shell-script
#                           :Also borrowed code found on 
#                           :   https://www.golinuxcloud.com/bash-getopts/

###############################################################################
###############################################################################
###########                                                      ##############
###########           Dealer Finder by Time and Game             ##############
###########                                                      ##############
###############################################################################
###############################################################################

function display_usage {
    echo "Usage: ./$(basename $0) [-h] [Options...]" >&2
    echo
    echo "This script analyzes the employee schedule to easily find the dealer for a specified game at a specified time."
    echo 
    echo "    -h    Displays this help text"
    echo "    -t    Specify the time (format [00-12][AM/PM], e.g. 08AM)"
    echo "    -d    Specify the date (format [MMDD], e.g. 0310 is March 10)"
    echo "    -g    Specify the game (BlackJack [B], Roulette [R], Texas Hold Em [T])"
    echo "    -v    Sets verbose mode on"
    echo
    exit 1
}

###################################
######   Verbose Function    ######
###################################
function verbose() {
    local MESSAGE="${@}"
    if [[ "${VERBOSE}" == true ]]; then
        echo "${MESSAGE}"
    fi
}

###################################
#####   Check Time Function   #####
###################################
function check_time() {
    local time="${@}"
    local re='(0[0-9]|1[0-2])([AaPp][Mm])'
    if [[ "${time}" =~ $re ]]; then
        TIME="${BASH_REMATCH[1]}:00:00 ${BASH_REMATCH[2]}"
        TIME=${TIME^^}
        verbose "Time is set to ${TIME}"
    else
        echo "Invalid time format. Please specify time as [00-12][AM/PM], e.g. 08AM"
        exit 1
    fi
 }

###################################
#####   Check Date Function   #####
###################################
function check_date() {
    local date="${@}"
    local re='(0[0-9]|1[0-2])(0[1-9]|[12][0-9]|3[01])'
    if [[ "${date}" =~ $re ]]; then
        SCHEDULE="${date}_Dealer_schedule"
        verbose "Schedule is set to ${date}"
    else
        echo "Invalid date format. Please specify date as [MMDD], e.g. 0310"
        exit 1
    fi
}

###################################
#####   Check Game Function   #####
###################################
function check_game() {
    local game="${@}"
    local re='([Bb|Rr|Tt])'
    if [[ "${game}" =~ $re ]]; then
        case ${game} in 
            B|b)
                GAME="BlackJack"
                dealer=`grep "${TIME}" "${SCHEDULE}" | awk -F" " '{print $3" "$4}'`
                ;;
            R|r)
                GAME="Roulette"
                dealer=`grep "${TIME}" "${SCHEDULE}" | awk -F" " '{print $5" "$6}'`
                ;;
            T|t)
                GAME="Texas Hold Em"
                dealer=`grep "${TIME}" "${SCHEDULE}" | awk -F" " '{print $7" "$8}'`
                ;;
        esac
        verbose "Game is set to ${GAME}"
    else
        echo "Invalid game. Please specify game as [B|R|T], e.g. B for BlackJack"
        exit 1
    fi
}

###################################
#####   Check File Function   #####
###################################
function check_file() {
    if [ -f "${@}" ]; then
        verbose "${@} file exists!" 
    else
        echo "No dealer schedule found for date ${DATE}"
        exit 1
    fi
}

# If no arguments are passed, display the usage message
if [[ ${#} -eq 0 ]]; then
    display_usage
fi

# List of arguments expected in the input
optstring=":hvt:d:g:"

# Check to see if verbose flag is set. If not checked before the getopts
# while-loop, the verbose flag may not be picked up if the user enters
# it after the -t or -d flags.
while getopts ${optstring} arg; do
    case ${arg} in
        v)
          VERBOSE='true'
          verbose "Verbose mode is ON"
          ;;
    esac
done

# Set the OPTIND back to 1
OPTIND=1

###################################
#########   Parse Input   #########
###################################

while getopts ${optstring} arg; do
    case ${arg} in
        v) 
          ;;
        h)
          display_usage
          ;;
        t)
          TIME="${OPTARG}"
          check_time ${TIME}
          ;;
        d) 
          DATE="${OPTARG}"
          check_date ${DATE}
          ;;
        g)
          GAME="${OPTARG}"
          check_game ${GAME}

          ;;
        :) 
          echo "Missing argument for -${OPTARG}."
          echo
          display_usage
          ;;
        ?) 
          echo "Invalid option: -${OPTARG}."
          echo
          display_usage
          ;;
    esac
done
shift $((OPTIND -1))

check_file ${SCHEDULE}
verbose "Checking ${SCHEDULE} for ${GAME} Dealer at ${TIME}"

if [ -n "${dealer}" ]; then
    echo "${dealer} was the ${GAME} dealer at ${TIME} on ${DATE}"
else
    echo "No dealer found at ${TIME} on {$DATE}"
fi

exit 0
