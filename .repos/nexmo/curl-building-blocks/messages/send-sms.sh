#!/bin/bash

source "../config.sh"
source "../jwt.sh"

curl -X POST https://api.nexmo.com/v0.1/messages \
  -H 'Authorization: Bearer '$JWT\
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d $'{
    "from": { "type": "sms", "number": '$FROM_NUMBER' },
    "to": { "type": "sms", "number": '$TO_NUMBER' },
    "message": {
      "content": {
        "type": "text",
        "text": "This is an SMS sent from the Messages API"
      }
    }
  }'
