#!/bin/bash

source "../config.sh"
source "../jwt.sh"

curl -X POST https://api.nexmo.com/beta/workflows \
  -H 'Authorization: Bearer '$JWT\
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d $'{
    "template":"failover",
    "workflow": [
      {
        "from": { "type": "messenger", "id": '$SENDER_ID' },
        "to": { "type": "messenger", "id": '$RECIPIENT_ID' },
        "message": {
          "content": {
            "type": "text",
            "text": "This is a Facebook Messenger Message sent via the Workflows API"
          }
        },
        "failover":{
          "expiry_time": 600,
          "condition_status": "read"
        }
      },
      {
        "from": {"type": "sms", "number": '$FROM_NUMBER'},
        "to": { "type": "sms", "number": '$TO_NUMBER'},
        "message": {
          "content": {
            "type": "text",
            "text": "This is an SMS sent via the Workflows API"
          }
        }
      }
    ]
  }'
