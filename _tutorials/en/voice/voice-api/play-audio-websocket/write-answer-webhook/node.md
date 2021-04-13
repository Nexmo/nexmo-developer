---
title: Write your answer webhook
description: Be alerted when you have incoming calls
---

# Write your answer webhook

When Vonage receives an inbound call on your virtual number, it will make a request to your `/webhooks/answer` route. This route should accept an HTTP `GET` request and return a [Nexmo Call Control Object (NCCO)](/voice/voice-api/ncco-reference) that tells Vonage how to handle the call.

Your NCCO should use the `text` action to greet the caller, and the `connect` action to connect the call to your webhook endpoint:

```javascript
'use strict'

const express = require('express');
const WaveFile = require('wavefile').WaveFile;
const fs = require('fs');

const app = express();
const expressWs = require('express-ws')(app);
const port = 3000;

app.use(express.json());
app.use(express.urlencoded({ extended: true }));

app.get('/webhooks/answer', (req, res) => {
    let nccoResponse = [
        {
            "action": "talk",
            "text": "Please wait while we connect you to the echo server"
        },
        {
            "action": "connect",
            "from": "NexmoTest",
            "endpoint": [
                {
                    "type": "websocket",
                    "uri": `wss://${req.hostname}/socket`,
                    "content-type": "audio/l16;rate=16000",
                }
            ]
        }
    ]

    res.status(200).json(nccoResponse);
});

app.listen(port, () => console.log(`Listening on port ${port}`));
```

The `type` of `endpoint` is `websocket`, the `uri` is the `/socket` route where your WebSocket server will be accessible and the `content-type` specifies the audio quality.
