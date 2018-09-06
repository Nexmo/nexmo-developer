#!/bin/bash
source "../../config.sh"

curl -X POST "https://api.nexmo.com/accounts/$ACCOUNT_ID/secrets" \
     -H 'Content-Type: application/json' \
     -u "$NEXMO_API_KEY:$NEXMO_API_SECRET" \
     -d '{"secret":"Th1s-I5-my_n3w-s3cr3t"}'

