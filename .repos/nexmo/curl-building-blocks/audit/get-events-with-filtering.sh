#!/bin/bash

source "../../config.sh"

SEARCH_TEXT = 'password'
DATE_FROM = '2018-07-01'
DATE_TO = '2018-08-01'

curl "https://api.nexmo.com/beta/audit/events?search_text=SEARCH_TEXT&date_from=DATE_FROM&date_to=DATE_TO" \
     -u 'NEXMO_API_KEY:NEXMO_API_SECRET'
