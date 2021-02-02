#!/bin/bash
FILE1="Roulette_Losses"
FILE2="Notes_Player_Analysis"
NAME="Mylie Schmidt"
grep '\-\$' ./03* > "$FILE1"
cat "$FILE1" | awk -F" " '{print $1" "$2}' | sed s/_win_loss_player_data:/' '/ | sed s_./_''_ > "$FILE2"
grep "$NAME" "$FILE1" | wc -l >> "$FILE2" && echo "$NAME" >> "$FILE2"
