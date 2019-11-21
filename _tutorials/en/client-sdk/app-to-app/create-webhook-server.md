---
title: Create a webhook server
description: In this step you learn how to create a suitable webhook server that supports an app-to-app call.
---

# Create a webhook server

Nexmo will make a request to your `answer_url` when an in-app voice call is made. You need to create a webhook server that is capable of receiving this request and returning an NCCO containing a `connect` action that will forward the call to the specified user.

Create a file named `server.js` and add the server code as shown.

``` javascript
'use strict';
const path = require('path');
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 9000;

app.use(express.static('node_modules/nexmo-client/dist'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

app.get('/webhooks/answer', (req, res) => {
    console.log("Answer:");
    console.log(req.query);
    var ncco = [{"action": "talk", "text": "No destination user - hanging up"}];
    var username = req.query.to;
    if (username) {
        ncco = [
            {
                "action": "talk",
                "text": "Connecting you to " + username
            },
            {
                "action": "connect",
                "endpoint": [
                    {
                        "type": "app",
                        "user": username
                    }
                ]
            }
        ]
    }
    res.json(ncco);
});

app.post('/webhooks/event', (req, res) => {
//    console.log("EVENT:");
//    console.log(req.body);
    res.status(200).end();
});

app.post('/webhooks/rtc', (req, res) => {
//    console.log("RTC:");
//    console.log(req.body);
    res.status(200).end();
});

app.get('/', function(req, res) {
    res.send("<p>Load <b>/user1</b> and then in an incognito tab load <b>/user2</b></p>");
});

app.get('/user1', function(req, res) {
    res.sendFile(path.join(__dirname + '/index1.html'));
});

app.get('/user2', function(req, res) {
    res.sendFile(path.join(__dirname + '/index2.html'));
});

app.listen(port, () => console.log(`Server listening on port ${port}!`));
```

The important part of this code is in the `answer` webhook handler:

1. Extraction of the destination user from the answer webhook query parameters.
2. Check that a username is provided. If not play a message and hang up.
3. The dynamically built NCCO then forwards the call to the destination application (user) using a `connect` action.

> **NOTE:** For additional logging, uncomment the `console.log()` calls.
