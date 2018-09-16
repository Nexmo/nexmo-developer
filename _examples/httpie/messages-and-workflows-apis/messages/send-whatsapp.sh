http POST 'https://api.nexmo.com/beta/messages' \
  'Authorization':'Bearer '$JWT\
  from:='{ "type": "whatsapp", "number": "WHATSAPP_NUMBER" }' \
  to:='{ "type": "whatsapp", "number": "TO_NUMBER" }' \
  message:='{
    "content": {
      "type": "text",
      "text": "This is a WhatsApp Message sent from the Messages API"
    }
  }'
