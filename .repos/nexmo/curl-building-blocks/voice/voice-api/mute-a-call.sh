#!/bin/bash
source "../../config.sh"
source "../../jwt.sh"

curl -X PUT https://api.nexmo.com/v1/calls/$UUID \
  -H "Authorization: Bearer "$JWT\
  -H "Content-Type: application/json"\
  -d '{"action": "mute"}'

sleep 5s

curl -X PUT https://api.nexmo.com/v1/calls/$UUID \
  -H "Authorization: Bearer "$JWT\
  -H "Content-Type: application/json"\
  -d '{"action": "unmute"}'
