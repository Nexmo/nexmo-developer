#!/bin/bash

source "../config.sh"
source "../jwt.sh"

curl -X POST https://api.nexmo.com/v0.1/messages \
     -u "$NEXMO_API_KEY:$NEXMO_API_SECRET" \
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
