---
title: Phone endpoint
menu_weight: 1
---

```json
[
  {
    "action": "talk",
    "text": "Please wait while we connect you"
  },
  {
    "action": "connect",
    "eventUrl": ["https://example.com/events"],
    "timeout": "45",
    "from": "447700900000",
    "endpoint": [
      {
        "type": "phone",
        "number": "447700900001",
        "dtmfAnswer": "2p02p"
      }
    ]
  }
]
```
