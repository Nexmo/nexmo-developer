http POST 'https://api.nexmo.com/beta/messages' \
  'Authorization':'Bearer '$JWT\
  from:='{ "type": "sms", "number": "FROM_NUMBER" }' \
  to:='{ "type": "sms", "number": "TO_NUMBER" }' \
  message:='{
    "content": {
      "type": "text",
      "text": "This is an SMS sent from the Messages API"
    }
  }'
