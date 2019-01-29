---
title: SIP endpoint
menu_weight: 3
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
        "type": "sip",
        "uri": "sip:rebekka@sip.mcrussell.com",
        "headers": { "location": "New York City", "occupation": "developer" }
      }
    ]
  }
]
```
