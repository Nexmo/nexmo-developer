#!/bin/bash

source "../config.sh"
source "../jwt.sh"

curl -X POST https://api.nexmo.com/v0.1/messages \
  -H 'Authorization: Bearer '$JWT\
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d $'{
    "from": { "type": "messenger", "id": '$FB_SENDER_ID' },
    "to": { "type": "messenger", "id": '$FB_RECIPIENT_ID' },
    "message": {
      "content": {
        "type": "text",
        "text": "This is a Facebook Messenger Message sent from the Messages API"
      }
    }
  }'
