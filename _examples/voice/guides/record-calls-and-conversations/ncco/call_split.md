---
title: Record a Call with Split Audio
menu_weight: 2
---

```json
[
  {
  "action": "record",
  "split" : "conversation",
  "eventUrl": ["https://example.com/recording"],
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
