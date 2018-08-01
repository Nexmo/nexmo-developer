#!/bin/bash
source "../../config.sh"
source "../../jwt.sh"

curl -X POST https://api.nexmo.com/v1/calls\
  -H "Authorization: Bearer "$JWT\
  -H "Content-Type: application/json"\
  -d '{"to":[{"type": "phone","number": "'$TO_NUMBER'"}],
      "from": {"type": "phone","number": "'$NEXMO_NUMBER'"},
      "answer_url":["https://developer.nexmo.com/ncco/tts.json"]}'
