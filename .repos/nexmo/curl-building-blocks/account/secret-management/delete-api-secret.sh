#!/bin/bash
source "../../config.sh"

curl -X DELETE "https://api.nexmo.com/accounts/$ACCOUNT_ID/secrets/$SECRET_ID" \
     -u "$NEXMO_API_KEY:$NEXMO_API_SECRET"

