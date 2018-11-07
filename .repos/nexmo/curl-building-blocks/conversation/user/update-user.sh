#!/bin/bash

source "../../config.sh"
source "../../jwt.sh"

curl -X "PUT" "https://api.nexmo.com/beta/users/$USER_ID" \
     -H 'Authorization: Bearer '$JWT\
     -H 'Content-Type: application/json' \
     -d $'{
  "name": "$USER_NEW_NAME",
  "display_name": "$USER_NEW_DISPLAY_NAME"
}'


