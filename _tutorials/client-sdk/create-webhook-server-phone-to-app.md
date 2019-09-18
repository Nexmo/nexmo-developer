---
title: Create a phone to app webhook server
description: In this step you learn how to create a suitable webhook server that enables your web app to accept an inbound PSTN phone call.
---

# Create a webhook server

You will need to create a webhook server. When the inbound call comes into Nexmo you can capture the destination number and use a dynamic NCCO to forward the call to the web application. This is achieved using a `connect` action of type `app`. Note the call is forwarded to an authenticated user who represents the agent handling the inbound call.

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
      "https://example.ngrok.io/webhooks/rtcevent"
    ],
    "from": "NEXMO_NUMBER",
    "endpoint": [
      {
        "type": "app",
        "user": "USERNAME"
      }
    ]
  }
]

app.get('/webhooks/answer', (req, res) => {
    console.log("Answer:");
    console.log(req.query);
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

> **NOTE:** Paste in your Nexmo number and your user name to the above code. The username is the username you used in creating the user JWT in the earlier step.

The important parts of this code are:

1. A static NCCO is used in this example to forward the inbound call to the agent identified by `USERNAME`.
2. The NCCO uses a `connect` action of type `app`.
3. Connect action is made based on the username provided.
4. NCCO specifies a URL that can be used to receive inbound RTC events.

## RTC events

Note the RTC_EVENT logging displays RTC events containing useful information, for example:

```
RTC_EVENT:
{ from: '4400000001',
  to: 'username',
  uuid: '77f2d8d1-7cde-48aa-ab0d-ed40afc3dd58',
  conversation_uuid: 'CON-70fb4afb-5cc9-429c-b000-1b06d7137d15',
  status: 'started',
  direction: 'outbound',
  timestamp: '2019-09-16T14:55:42.396Z' }
```

The information in the body of the event can also be extracted and used depending on the requirements of your application. For example, you may want to direct the inbound call to a specific agent depending on what Nexmo number was being used for the inbound call.

## Running the webhook server

You can then run your webhook server with:

```
node server.js
```

> **NOTE:** This is a good point to make sure [you have Ngrok running](/client-sdk/tutorials/app-to-phone/prerequisites#how-to-run-ngrok).
