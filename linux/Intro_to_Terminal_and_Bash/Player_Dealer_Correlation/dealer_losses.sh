#!/bin/bash

echo "March 10"
grep "05:00:00 AM" 0310_Dealer_schedule | awk -F" " '{print "05:00:00 AM "$5" "$6}'
grep "08:00:00 AM" 0310_Dealer_schedule | awk -F" " '{print "08:00:00 AM "$5" "$6}'
grep "02:00:00 PM" 0310_Dealer_schedule | awk -F" " '{print "02:00:00 PM "$5" "$6}'
grep "08:00:00 PM" 0310_Dealer_schedule | awk -F" " '{print "05:00:00 PM "$5" "$6}'
grep "11:00:00 PM" 0310_Dealer_schedule | awk -F" " '{print "11:00:00 PM "$5" "$6}'

echo "March 12"
grep "05:00:00 AM" 0312_Dealer_schedule | awk -F" " '{print "05:00:00 AM "$5" "$6}'
grep "08:00:00 AM" 0312_Dealer_schedule | awk -F" " '{print "08:00:00 AM "$5" "$6}'
grep "02:00:00 PM" 0312_Dealer_schedule | awk -F" " '{print "02:00:00 PM "$5" "$6}'
grep "08:00:00 PM" 0312_Dealer_schedule | awk -F" " '{print "08:00:00 PM "$5" "$6}'
grep "11:00:00 PM" 0312_Dealer_schedule | awk -F" " '{print "11:00:00 PM "$5" "$6}'

echo "March 15"
grep "05:00:00 AM" 0315_Dealer_schedule | awk -F" " '{print "05:00:00 AM "$5" "$6}'
grep "08:00:00 AM" 0315_Dealer_schedule | awk -F" " '{print "08:00:00 AM "$5" "$6}'
grep "02:00:00 PM" 0315_Dealer_schedule | awk -F" " '{print "02:00:00 PM "$5" "$6}'

grep Billy Dealers_working_during_losses| wc -l
