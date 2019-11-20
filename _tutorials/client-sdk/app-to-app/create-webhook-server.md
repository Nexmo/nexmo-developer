---
title: Create a webhook server
description: In this step you learn how to create a suitable webhook server that supports an app-to-app call.
---

# Create a webhook server

Nexmo will make a request to your `answer_url` when an inbound call is received. You need to create a webhook server that is capable of receiving this request and returning an NCCO containing a `connect` action that will forward the call to the PSTN phone number. You do this by extracting the destination number from the `to` query parameter and returning it in your response.

Create a file named `server.js` and add the server code as shown. Modify the values in `allowed_numbers` to include only those phone numbers that you will permit incoming calls to be forwarded to:

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

app.get('/webhooks/answer', (req, res) => {
    console.log("Answer:");
    console.log(req.query);
    var dest_number = req.query.to;

    // Make sure phone number is allowed to be called
    var allowed_numbers = [
      '14155550100',
      '14155550103',
    ];

    if (allowed_numbers.indexOf(dest_number) === -1) {
        return res.json([{
            "action": "talk",
            "text": "Sorry, that number is not permitted"
        }]);
    }

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

app.get('/', function(req, res) {
    res.sendFile(path.join(__dirname + '/index.html'));
});

app.listen(port, () => console.log(`Server listening on port ${port}!`));
```

The important parts of this code are in the `answer` webhook handler:

1. Extraction of the destination number from the answer webhook query parameters.
2. Check that the provided number is in the list of numbers you will allow calls to be forwarded to. This is important for preventing fraudulent use of your account.
3. The dynamically built NCCO then forwards the call to the destination phone using a `connect` action.
