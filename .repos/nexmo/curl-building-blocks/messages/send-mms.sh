#!/bin/bash

source "../config.sh"

curl -X POST https://api.nexmo.com/v0.1/messages \
  -u "$NEXMO_API_KEY:$NEXMO_API_SECRET" \
  -H 'Content-Type: application/json' \
  -H 'Accept: application/json' \
  -d '{ 
   "from":{
        "type": "mms",    
        "number": '$FROM_NUMBER'
   },
   "to":{
        "type": "mms",
        "number": '$TO_NUMBER'
   },
   "message":{ 
      "content":{
          "type": "image",
          "image": {
              "url": '$IMG_URL'
          }
      }
   }
}'
