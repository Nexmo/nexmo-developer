#!/usr/bin/env bash

source "../config.sh"
source "../jwt.sh"

curl -X POST \
  https://api.nexmo.com/beta/messages \
  -H 'Authorization: Bearer' $JWT \
  -H 'Content-Type: application/json' \
  -d '{
   "from":{
      "type":"whatsapp",
      "number":"WHATSAPP_NUMBER"
   },
   "to":{
      "type":"whatsapp",
      "number":"TO_NUMBER"
   },
   "message":{
      "content":{
         "type":"template",
         "template":{
            "name":"whatsapp:hsm:technology:nexmo:verify",
            "parameters":[
               {
                  "default":"Nexmo Verification"
               },
               {
                  "default":"64873"
               },
               {
                  "default":"10"
               }
            ]
         }
      }
   }
}'
