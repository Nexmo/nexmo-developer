#!/usr/bin/env bash
source "../config.sh"

curl -X GET "https://api.nexmo.com/verify/control/json?api_key=$NEXMO_API_KEY&api_secret=$NEXMO_API_SECRET&request_id=$REQUEST_ID&cmd=cancel"
