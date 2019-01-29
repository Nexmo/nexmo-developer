---
title: WebSocket endpoint
menu_weight: 2
---

```json
[
  {
    "action": "talk",
    "text": "Please wait while we connect you"
  },
  {
    "action": "connect",
    "eventUrl": [
      "https://example.com/events"
    ],
    "from": "447700900000",
    "endpoint": [
      {
        "type": "websocket",
        "uri": "ws://example.com/socket",
        "content-type": "audio/l16;rate=16000",
        "headers": {
            "name": "J Doe",
            "age": 40,
            "address": {
                "line_1": "Apartment 14",
                "line_2": "123 Example Street",
                "city": "New York City"
            },
            "system_roles": [183493, 1038492, 22],
            "enable_auditing": false,
            "manager_id": null
        }
      }
    ]
  }
]
```
