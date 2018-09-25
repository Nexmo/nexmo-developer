#!/bin/bash

source "../config.sh"
source "../jwt.sh"

curl -X POST https://api.nexmo.com/beta/messages \
  -H 'Authorization: Bearer '$JWT\
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d $'{
    "from": { "type": "messenger", "id": '$SENDER_ID' },
    "to": { "type": "messenger", "id": '$RECIPIENT_ID' },
    "message": {
      "content": {
        "type": "text",
        "text": "This is a Facebook Messenger Message sent from the Messages API"
      }
    }
  }'
