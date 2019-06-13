---
title: Fallback NCCO
menu_weight: 5
---

You can provide a fallback for Calls that do not connect. To do this set the `eventType` to `synchronous` and return an NCCO from the `eventUrl` if the Call enters any of the following states:

* `timeout` - your user did not answer your call with `ringing_timer` seconds
* `failed` - the call failed to complete
* `rejected` - the call was rejected
* `unanswered` - the call was not answered
* `busy` - the person being called was on another call


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
