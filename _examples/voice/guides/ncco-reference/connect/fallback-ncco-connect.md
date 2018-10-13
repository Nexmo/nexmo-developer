---
title: Fallback NCCO
menu_weight: 4
---

```json
[
  {
    "action": "connect",
    "from": "447700900000",
    "timeout": 5,
    "eventType": "synchronous",
    "eventUrl": [
      "https://example.com/event-fallback"
    ],
    "endpoint": [
      {
        "type": "phone",
        "number": "447700900001"
      }
    ]
  }
]
```
