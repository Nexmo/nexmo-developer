---
title: Create a webhook server
description: In this step you learn how to create a suitable webhook server that enables your web app to accept an inbound PSTN phone call.
---

# Create a webhook server

You will need to create a webhook server. When the inbound call comes into Nexmo you can capture the originating number and use a dynamic NCCO to forward the call to the web application. This is achieved by using a `connect` action of type `app`. The call is forwarded to an authenticated user who represents the agent handling the inbound call.

Create a `server.js` file and add the code for the server:

> **NOTE:** Paste in your Nexmo number and your user name to the code below. The username is the one you created a JWT for in a previous step.

``` javascript
'use strict';
const path = require('path');
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(express.static('node_modules/nexmo-client/dist'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

const ncco = [
  {
    "action": "talk",
    "text": "Please wait while we connect you to an agent"
  },
  {
    "action": "connect",
    "from": "NEXMO_NUMBER",
    "endpoint": [
      {
        "type": "app",
        "user": "MY_USER_NAME"
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

app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname + '/index.html'));
});

app.listen(port, () => console.log(`Server listening on port ${port}!`));

```

The important parts of this code are:

1. A static NCCO is used in this example to forward the inbound call to the agent identified by `MY_USER_NAME`.
2. The NCCO uses a `connect` action of type `app`, providing a username to connect to.
