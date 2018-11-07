#!/bin/bash

source "../../config.sh"
source "../../jwt.sh"

curl -X "POST" "https://api.nexmo.com/beta/conversations" \
     -H 'Authorization: Bearer '$JWT\
     -H 'Content-Type: application/json' \
     -d $'{
  "name": "$CONV_NAME",
  "display_name": "$CONV_DISPLAY_NAME"
}'


