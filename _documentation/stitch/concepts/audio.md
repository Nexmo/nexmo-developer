---
title: Audio
description: Introduction to Audio conversations in Stitch.
navigation_weight: 5
---

# Audio

Audio communication in Stitch can take place via three main methods:

1. App to app over IP
2. Phone to App
3. App to Phone

Audio streams can be enabled and disabled in a Conversation so that Members can communicate with voice.

## App to App

In this scenario communication takes place over IP. Your application provides a means for Users to connect to a conversation.

## Phone to App

In this scenario a user will typically call a Nexmo Number using a phone over the PSTN (landline or cellular). The Nexmo Number is associated with a Nexmo Application. The Nexmo application will connect the inbound user to an endpoint in the target web application (or app running on a mobile device).

The connection to the Stitch app is typically made via an NCCO:

``` json
{
    "action": "connect",
    "from": "447700900001",
    "endpoint": [
    {
        "type": "app",
        "user": "jamie"
    }
    ]
}
```

Note the type of endpoint is `app`, which is a Stitch app.

## App to Phone

In this scenario your app would take your destination number, and make the call using the Stitch call API. This will automatically call into your Stitch Nexmo application. The number you provide to your app is passed to the `to` query parameter of the answer URL of your Stitch Nexmo Application. Your Nexmo Stitch Application would then forward to your `to_number` using an NCCO. The following code provides an example of a simple server that would forward the call:

``` javascript
'use strict';
const express = require('express');
const bodyParser = require('body-parser');
const app = express();

app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

app.post('/webhooks/event', (req, res) => {
  console.log(req.body);
  res.status(200).end();
});

app.get('/webhooks/answer', (req, res) => {

    var to_number = req.query.to;
    var nexmo_number = NEXMO_NUMBER;
    var ncco = [
    {
      action: "talk",
      text: "Forwarding you to your destination"
    },
    {
      "action": "connect",
      "from": nexmo_number,
      "endpoint": [
        {
          "type": "phone",
          "number": to_number
        }
      ]
    }
  ];
  res.json(ncco);
})

const server = app.listen(9000, () => {
  console.log('Express server listening on port %d in %s mode', server.address().port, app.settings.env);
});
```

## Media Events

Media events will fire in a Conversation when media state changes for a Member. This can be when an Audio stream is started or ended.

## References

* [NCCO reference](/voice/voice-api/ncco-reference)