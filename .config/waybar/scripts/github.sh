#!/bin/bash

TOKEN=$(cat ~/.config/gh-notif-token)
COUNT=$(curl -H "Authorization: token $TOKEN" https://api.github.com/notifications -s | jq length)
# if [ $COUNT != 0 ]; then echo " $COUNT"; else echo ""; fi
if [ $COUNT != 0 ]; then echo ""; fi

