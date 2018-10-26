#!/bin/bash

source "../../config.sh"
source "../../jwt.sh"

# Gets a list of conversations from an application ID (app ID is in the JWT).
curl "https://api.nexmo.com/beta/conversations" \
     -H 'Authorization: Bearer '$JWT\
     -H 'Content-Type: application/json'


