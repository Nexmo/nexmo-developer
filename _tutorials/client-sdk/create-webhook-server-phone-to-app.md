---
title: Create a webhook server
description: In this step you learn how to create a suitable webhook server.
---

# Create a webhook server

You will need to create a webhook server. When the inbound call comes into Nexmo you can capture the destination number and use a dynamic NCCO to forward the call to the PSTN phone.

Add the code for the server to the file `server.js`:

``` javascript
'use strict';
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000; // change port number as required

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const ncco = [
  {
    "action": "talk",
    "text": "Please wait while we connect you to an agent"
  },
  {
    "action": "connect",
    "eventUrl": [
      "https://tbedford.ngrok.io/webhooks/rtcevent"
    ],
    "from": "NEXMO_NUMBER",
    "endpoint": [
      {
        "type": "app",
        "user": "USER"
      }
    ]
  }
]

app.get('/webhooks/answer', (req, res) => {
    console.log("Answer:");
    console.log(req.query);
    var dest_number = req.query.to;
    res.json(ncco);
});

app.post('/webhooks/event', (req, res) => {
    console.log("EVENT:");
    console.log(req.body);
    res.status(200).end();
});

app.post('/webhooks/rtcevent', (req, res) => {
    console.log("RTC_EVENT:");
    console.log(req.body);
    res.status(200).end();
});

app.listen(port, () => console.log(`Server listening on port ${port}!`));

```

> **NOTE:** Paste in your Nexmo number and your user name to the above code. The user is the username you used in creating the agent JWT in the earlier step.

You can then run your webhook server with:

```
node server.js
```

> **NOTE:** This is a good point to make sure [you have Ngrok running](/client-sdk/tutorials/app-to-phone/prerequisites#how-to-run-ngrok).
