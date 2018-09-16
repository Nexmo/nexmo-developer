#!/bin/bash
source "../../config.sh"

curl -X "POST" "https://rest.nexmo.com/sms/json" \
  -d "from=AcmeInc" \
  -d "text=A text message sent using the Nexmo SMS API" \
  -d "to=$TO_NUMBER" \
  -d "api_key=$NEXMO_API_KEY" \
  -d "api_secret=$NEXMO_API_SECRET"
