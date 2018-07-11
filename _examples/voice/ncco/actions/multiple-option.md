---
title: Multiple option
menu_weight: 2
---

```json
[
  {
    "action": "record",
    "eventUrl": ["https://example.com/recordings"],
    "endOnSilence": "3"
  },
  {
    "action": "connect",
    "eventUrl": ["https://example.com/events"],
    "from":"441632960960",
    "endpoint": [
      {
        "type": "phone",
        "number": "441632960961"
      }
    ]
  }
]
```
