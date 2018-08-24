#!/bin/bash
source "../../config.sh"
source "../../jwt.sh"

curl "https://api.nexmo.com/v1/calls" \
  -H "Authorization: Bearer "$JWT \

