---
title: Handle an Inbound Call
description: Handle an Inbound Call
---

## Handle an Inbound Call

When Nexmo receives an inbound call to your Nexmo number it makes a request to the event webhook endpoint you set when you [created a Voice application](#create-a-voice-application). A webhook is also sent each time *DTMF* input is collected from the user.

This tutorial code uses a simple router to handle these inbound webhooks. The router determines the requested URI path and uses it to map the caller's navigation through the phone menu - the same as URLs in web application.

Data from webhook body is captured and passed in the request information to the *index.js*.

Nexmo sends a webhook for every change in call status. For example, when the phone is `ringing`, the call has been `answered` or is `complete`. The application uses an *expressjs* route to log the data received by the `/event` endpoint for debug purposes. Every other request goes to the code that handles the user input. Here is the code:

```javascript
<?php

// index.js
app.get('/answer', (req, res) => {
  const ncco = [{
      action: 'talk',
      bargeIn: true,
      text: 'Hello. Please enter a digit.'
    },
    {
      action: 'input',
      maxDigits: 1,
      eventUrl: [`${req.protocol}://${req.get('host')}/dtmf`]
    }
  ]

  res.json(ncco)
})

app.post('/event', (req, res) => {
  console.log(req.body)
  res.send(200);
})

app.post('/dtmf', (req, res) => {
  const ncco = [{
    action: 'talk',
    text: `You pressed ${req.body.dtmf}`
  }]

  res.json(ncco)
})
```

Any request that is not for `/event` is mapped to an `/answer` route. Incoming request data is passed to that method. The router retrieves the NCCO (Nexmo Call Control Object) and sends it in the response as a JSON body with the correct `Content-Type`.




