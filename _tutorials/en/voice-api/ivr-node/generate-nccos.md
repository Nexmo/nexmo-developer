---
title: Generate NCCOs
description: Generate NCCOs
---

## Generate NCCOs

A Nexmo Call Control Object (NCCO) is a JSON array that is used to control the flow of a Voice API call. Nexmo expects your answer webhook to return an NCCO to control the various stages of the call.

To manage NCCOs this example application uses array of objects.

The router handles encoding to JSON:

```javascript
// index.js

 const ncco = [{
      action: 'talk',
      bargeIn: true,
      text: 'Hello. Please enter a digit.'
    },
    {
      action: 'input',
      maxDigits: 1,
      eventUrl: [`${req.protocol}://${req.get('host')}/webhooks/dtmf`]
    }
  ]

  res.json(ncco)
```


