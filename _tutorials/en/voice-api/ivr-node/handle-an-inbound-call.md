---
title: Handle an Inbound Call
description: Handle an Inbound Call
---

## Handle an Inbound Call

When Nexmo receives an inbound call to your Nexmo number it makes a request to the event webhook endpoint you set when you [created a Voice application](/voice/voice-api/tutorials/ivr-node/voice-api/ivr-node/create-a-voice-application/). A webhook is also sent each time *DTMF* input is collected from the user.

This tutorial code uses a simple router to handle these inbound webhooks. The router determines the requested URI path and uses it to map the caller's navigation through the phone menu - the same as URLs in web application.

Data from webhook body is captured and passed in the request information to the Menu:

```javascript
// index.js

const uri = ltrim(req.url.split("?")[0], "/");
const data = req.body;
  
```

Nexmo sends a webhook for every change in call status. For example, when the phone is `ringing`, the call has been `answered` or is `complete`. The application uses a `switch()` statement to log the data received by the `/event` endpoint for debug purposes. Every other request goes to the code that handles the user input. Here is the code:

```javascript
// index.js

switch (uri) {
    case "event":
      console.log(data);
      break;

    default:
      let ivr = new Menu(config);
      let method = uri.toLowerCase() + "Action";

      ivr[method](data);
      res.json(ivr.getStack());
      break;
    // code block
  }
```

Any request that is not for `/event` is mapped to an `Action` method on the `Menu` object. Incoming request data is passed to that method. The router retrieves the NCCO (Nexmo Call Control Object) and sends it in the response as a JSON body with the correct `Content-Type`.

The `config` array is passed to the `Menu` object, as it needs to know the base URL for the application when generating NCCOs that could include callback URLs:

```javascript
// src/Menu.js
    constructor(config)
    {
        this.config = config;
    }
```
