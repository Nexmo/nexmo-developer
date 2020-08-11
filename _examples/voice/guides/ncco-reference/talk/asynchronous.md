---
title: Asynchronous
menu_weight: 2
---


```json
[
  {
    "action": "talk",
    "text": "Welcome to a Voice API I V R. ",
    "language": "en-GB",
    "bargeIn": false
  },
  {
    "action": "talk",
    "text": "Press 1 for maybe and 2 for not sure followed by the hash key",
    "language": "en-GB",
    "bargeIn": true
  },
  {
    "action": "input",
    "submitOnHash": true,
    "eventUrl": ["https://example.com/ivr"]
  }
]
```
