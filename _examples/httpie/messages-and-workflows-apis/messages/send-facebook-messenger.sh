http POST 'https://api.nexmo.com/beta/messages' \
  'Authorization':'Bearer '$JWT\
  from:='{ "type": "messenger", "id": "SENDER_ID" }' \
  to:='{ "type": "messenger", "number": "RECIPIENT_ID" }' \
  message:='{
    "content": {
      "type": "text",
      "text": "This is a Facebook Messenger Message sent from the Messages API"
    }
  }'
