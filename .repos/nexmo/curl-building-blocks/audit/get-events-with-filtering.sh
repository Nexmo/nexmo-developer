#!/bin/bash

source "../config.sh"

curl "https://api.nexmo.com/beta/audit/events?search_text=$SEARCH_TEXT&date_from=$DATE_FROM&date_to=$DATE_TO" \
     -u "$NEXMO_API_KEY:$NEXMO_API_SECRET"
