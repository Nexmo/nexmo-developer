#!/bin/bash

source "../config.sh"

curl -X "OPTIONS" "https://api.nexmo.com/beta/audit/events" \
     -u "$NEXMO_API_KEY:$NEXMO_API_SECRET"
