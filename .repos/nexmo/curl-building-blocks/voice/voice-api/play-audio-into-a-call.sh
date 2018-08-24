#!/bin/bash
source "../../config.sh"
source "../../jwt.sh"

curl -X PUT https://api.nexmo.com/v1/calls/$UUID/stream \
  -H "Authorization: Bearer "$JWT\
  -H "Content-Type: application/json"\
  -d '{"stream_url": ["https://raw.githubusercontent.com/nexmo-community/ncco-examples/gh-pages/assets/welcome_to_nexmo.mp3"]}'
