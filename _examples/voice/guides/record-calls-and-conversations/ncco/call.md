---
title: Record a Call
menu_weight: 2
---

```json
[
  {
  "action": "record",
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
