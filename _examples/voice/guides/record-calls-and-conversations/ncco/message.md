---
title: Record a Message
menu_weight: 1
---

```json
[
  {
      "action": "talk",
      "text": "Please leave a message after the tone, then press #. We will get back to you as soon as we can"
  },
  {
      "action": "record",
      "eventUrl": ["http://example.com/recording"],
      "endOnSilence": "3",
      "endOnKey" : "#",
      "beepStart": "true"
  },
  {
      "action": "talk",
      "text": "Thank you for your message. Goodbye"
  }
]
```
