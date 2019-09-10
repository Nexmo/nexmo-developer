---
title: Create a webhook server
description: In this step you see how to create a suitable webhook server.
---

# Create a webhook server

You will need to create a webhook server. When the inbound call comes into Nexmo you can capture the destination number and use a dynamic NCCO to forward the call to the PSTN phone.

The code for the server:

``` javascript
'use strict';
const express = require('express');
const bodyParser = require('body-parser');
const app = express();

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))

app.get('/webhooks/answer', (req, res) => {
    console.log("Answer:");
    console.log(req.query);
    var dest_number = req.query.to;
    const ncco = [{
        "action": "connect",
        "endpoint": [{
            "type": "phone",
            "number": dest_number
        }]
    }]
    res.json(ncco);
});

app.post('/webhooks/event', (req, res) => {
    console.log("EVENT:");
    console.log(req.body);
    res.status(200).end();
});

app.listen(9000)
```

