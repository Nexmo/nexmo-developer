#!/usr/bin/env bash
source "../../config.sh"
source "../../jwt.sh"

curl $RECORDING_URL \
  -H "Authorization: Bearer "$JWT \
  --output recording.mp3

