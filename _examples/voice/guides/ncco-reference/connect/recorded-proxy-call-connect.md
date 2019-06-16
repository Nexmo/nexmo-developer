---
title: Recorded proxy call
menu_weight: 6
---

```json
[
  {
    "action": "record",
    "eventUrl": ["https://example.com/recordings"]
  },
  {
    "action": "connect",
    "eventUrl": ["https://example.com/events"],
    "from": "447700900000",
    "endpoint": [
      {
        "type": "phone",
        "number": "447700900001"
      }
    ]
  }
]
```
