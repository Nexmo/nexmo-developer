#!/bin/bash
source "../../config.sh"
source "../../jwt.sh"

curl -X PUT https://api.nexmo.com/v1/calls/$UUID/dtmf \
  -H "Authorization: Bearer "$JWT\
  -H "Content-Type: application/json"\
  -d '{"digits": 1713}'
