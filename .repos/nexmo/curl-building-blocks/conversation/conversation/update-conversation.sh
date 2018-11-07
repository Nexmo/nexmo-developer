#!/bin/bash

source "../../config.sh"
source "../../jwt.sh"

curl -X "PUT" "https://api.nexmo.com/beta/conversations/$CONVERSATION_ID" \
     -H 'Authorization: Bearer '$JWT\
     -H 'Content-Type: application/json' \
     -d $'{
  "name": "$CONV_NEW_NAME",
  "display_name": "$CONV_NEW_DISPLAY_NAME"
}'



