#!/usr/bin/env bash

source "../config.sh"
source "../jwt.sh"

curl -X POST https://api.nexmo.com/v0.1/dispatch \
  -H 'Authorization: Bearer '$JWT\
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d $'{
    "template":"failover",
    "workflow": [
      {
        "from": { "type": "mms", "number": '$FROM_NUMBER' },
        "to": { "type": "mms", "number": '$TO_NUMBER' },
        "message": {
          "content": {
            "type": "img",
            "image": { "url": "$IMG_URL" }
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
            "text": "This is an SMS sent via the Dispatch API"
          }
        }
      }
    ]
  }'