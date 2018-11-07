#!/bin/bash

source "../../config.sh"
source "../../jwt.sh"

curl -X "POST" "https://api.nexmo.com/beta/users" \
     -H 'Authorization: Bearer '$JWT\
     -H 'Content-Type: application/json' \
     -d $'{
  "name": "$USER_NAME",
  "display_name": "$USER_DISPLAY_NAME"
}'


