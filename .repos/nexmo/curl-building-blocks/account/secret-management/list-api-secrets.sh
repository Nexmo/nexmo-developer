#!/bin/bash
source "../../config.sh"

curl "https://api.nexmo.com/accounts/$ACCOUNT_ID/secrets" \
    -u "$NEXMO_API_KEY:$NEXMO_API_SECRET"

