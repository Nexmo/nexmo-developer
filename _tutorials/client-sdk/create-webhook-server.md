---
title: Create a webhook server
description: In this step you see how to create a suitable webhook server.
---

# Create a webhook server

You will need to create a webhook server. When the inbound call comes into Nexmo you can capture the destination number and use a dynamic NCCO to forward the call to the PSTN phone.

Add the code for the server to the file `server.js`:

``` javascript
'use strict';
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
const port = 3000;

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: true }));

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

app.listen(port, () => console.log(`Server listening on port ${port}!`));
```

If you've not already done so initialize your project directory with:

```
npm init
```

Then, as this server uses `Express.js` you need to install it with:

```
npm install express
```

You can then run your webhook server with:

```
node server.js
```

The important parts of this code are in the answer webhook handler:

1. Extraction of the destination number from the answer webhook query parameters.
2. The dynamically built NCCO that forwards the call to the destination phone.

Note the destination number is extracted from the `to` query parameter. The NCCO is then built dynamically using this number and a `connect` action is used to forward the voice call to the destination phone.

> **NOTE:** This is a good point to make sure [you have Ngrok running](/client-sdk/tutorials/app-to-phone/prerequisites#how-to-run-ngrok).
