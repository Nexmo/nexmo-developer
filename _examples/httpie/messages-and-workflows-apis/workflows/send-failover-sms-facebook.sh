http POST 'https://api.nexmo.com/beta/workflows' \
  'Authorization':'Bearer '$JWT\
  template="failover" \
  workflow:='[
    {
      "from": { "type": "messenger", "id": "SENDER_ID" },
      "to": { "type": "messenger", "id": "RECIPIENT_ID" },
      "message": {
        "content": {
          "type": "text",
          "text": "This is a Facebook Messenger message sent from the Workflows API"
        }
      },
      "failover": {
        "condition_status": "read",
        "expiry_time": 600
      },
    },
    {
      "to": { "type": "sms", "number": "TO_NUMBER" },
      "from": { "type": "sms", "number": "FROM_NUMBER" }
      "message": {
        "content": {
          "type": "text",
          "text": "This is an SMS sent from the Workflows API"
        }
      },
    }
  ]'
