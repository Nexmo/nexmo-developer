#!/usr/bin/env bash
source "../../config.sh"
source "../../jwt.sh"

curl -X PUT https://api.nexmo.com/v1/calls/$UUID \
  -H "Authorization: Bearer "$JWT \
  -H "Content-Type: application/json"\
  -d '{"action": "transfer",
      "destination": {"type": "ncco", "url": ["https://developer.nexmo.com/ncco/tts.json"]}}'

