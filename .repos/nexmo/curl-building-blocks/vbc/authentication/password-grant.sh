#!/usr/bin/env bash
source "../../config.sh"

curl -k -d "grant_type=password&username=$VBC_USERNAME&password=$VBC_PASSWORD" \
        -d "&client_id=$VBC_CLIENT_ID&client_secret=$VBC_CLIENT_SECRET" \
        https://api.entva0.qa.vonagenetworks.net/token
