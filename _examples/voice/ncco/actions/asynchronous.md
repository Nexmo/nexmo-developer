---
title: Asynchronous
menu_weight: 4
---

```json
[
  {
    "action": "talk",
    "text": "Welcome to a Voice API I V R. ",
    "voiceName": "Amy",
    "bargeIn": false
  },
  {
    "action": "talk",
    "text": "Press 1 for maybe and 2 for not sure followed by the hash key",
    "voiceName": "Amy",
    "bargeIn": true
  },
  {
    "action": "input",
    "type": ["dtmf"],
    "dtmf: {
      "submitOnHash": "true"
    },
    "eventUrl": ["https://example.com/ivr"]
  }
]
```
