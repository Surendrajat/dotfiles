#!/bin/bash

TOKEN=$(cat $PRIV_ENV_FILE | grep gh-notif-token | cut -d'=' -f2)
COUNT=$(curl -H "Authorization: token $TOKEN" https://api.github.com/notifications -s | jq length)
# if [ $COUNT != 0 ]; then echo " $COUNT"; else echo ""; fi
if [ $COUNT != 0 ]; then echo ""; fi

