---
title: Call whisper using onAnswer
products: voice/voice-api
description: Play a message to a call before connecting it to another call
languages:
  - Node
---

## What's our use case?

Imagine that you run an internal help desk at Acme Corporation. You get a couple of hundred calls per day from people asking you to fix their problems, which you do fairly quickly once you understand the context around the issue.

Wouldn't it be great if you could get a quick summary of who is calling, how many times they've called in the past 7 days and who's previously dealt with them before you get connected to a phone call with them? Using Nexmo's new `onAnswer` functionality, you can!

## Creating an onAnswer NCCO

Adding `onAnswer` functionality to your calls couldn't be easier! It's the same `connect` action that you know and love, with one small addition, an `onAnswer` key in the NCCO. This contains a URL for a new NCCO that will be executed when the call is connected.

Let's take a look at what that NCCO would look like. This is your standard `connect` NCCO with `onAnswer` added:

```json
[
  { 
    "action": "talk", 
    "text": "Thanks for calling. Connecting you to the help desk now"
  },
  { 
    "action": "connect", 
    "eventUrl": ["https://example.com/event"], 
    "from": "<from_number>", 
    "endpoint": [{ 
      "type": "phone", 
      "number": "14155550105",
      "onAnswer": {"url":"https://example.com/on-answer"} 
    }]
  }
]
```

When someone calls the help desk, they'll hear a welcome message and then the call will be connected to the help desk. When the help desk answers the call, Nexmo will make a request to your `onAnswer` URL and execute that NCCO before merging the calls. 

That's a lot to take in, so let's look at how it all fits together assuming that your `onAnswer` NCCO contains the following actions:

```json
[
  { 
    "action": "talk", 
    "text": "There is a help request from Michael. They have called 4 times this week and have spoken to Alice, Bob and Charlie"
  }
]
```

* Employee calls a Nexmo number
* Nexmo request the `answerUrl` NCCO
* This NCCO contains a `talk` action and a `connect` action
* Nexmo call the help desk and place them in their own conversation
* Nexmo request the NCCO located at `onAnswer.url` and execute the actions it contains
* The help desk is transferred to the original conversation and the one they were in is deleted

## Creating an application

Now that we've covered how `onAnswer` works, let's take a look at the code we need to make this happen. We're going to use Node, but feel free to implement it in any language you like.

As our application needs to be publicly accessible for Nexmo to make a request to our `answerUrl`, we need to [open a tunnel to our local machine using ngrok](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/). Our application will run on port 3000, so let's forward that now:

```bash
ngrok http 3000
```

Make a note of the `ngrok` URL created (it'll look like `http://abc123.ngrok.io` on the screen that appears) as we'll need it for the next section.

Before we can handle the call, we need to create an application and rent a number from Nexmo (make sure to replace https://example.com` with your `ngrok` URL in the following commands!)

> This next section assumes that you have the [Nexmo CLI](https://github.com/Nexmo/nexmo-cli) installed. You can install it with `npm install -g nexmo`

```bash
nexmo app:create "OnAnswerTest" https://example.com/answer https://example.com/event --keyfile private.key
nexmo number:buy --country_code US --confirm
nexmo link:app <number> <application_id>
```

Once that's all configured, we can start to build our application. In the same directory as `private.key`, run `npm install express --save`. This will download the dependencies we need.

Next, create `app.js` with the following contents, replacing `<FROM_NUMBER>` with the Nexmo number you purchased earlier, `<TO_NUMBER>` with the number to forward the call to and `https://example.com` with your `ngrok` URL. This will register two endpoints in our application - one for our default `answerUrl` for callers and another to play the `onAnswer` message to the number we're connecting to.

```javascript
const express = require('express')
const app = express()

app.get('/answer', (req, res) => {
  res.json([
    {
      "action": "talk", 
      "text": "Thanks for calling. Connecting you to the help desk now"
    },
    {
      "action": "connect", 
      "eventUrl": ["https://example.com/event"],
      "from": "<FROM_NUMBER>",
      "endpoint": [{
        "type": "phone",
        "number": "<TO_NUMBER>",
        "onAnswer": {"url":`https://example.com/on-answer?original=${req.query.from}`}
      }]
    }
  ]);
});

app.get('/on-answer', (req, res) => {
  const staff = {
    "14155550101": {"name": "Michael", "count": 4, "spoken_to": "Alice, Bob and Charlie"},
    "14155550102": {"name": "Don", "count": 2, "spoken_to": "Bob"}
  };

  const caller = staff[req.query.original];

  res.json([
    { 
      "action": "talk",
      "text": `There is a help request from ${caller.name}. They have called ${caller.count} times this week and have spoken to ${caller.spoken_to}`
    }
  ]);
});

app.listen(3000, () => console.log('Application listening on port 3000!'));
```

## Conclusion

That's all there is to it! The final thing to do test your application with a real phone number. 

Run your application using `node app.js` and it'll start listening on port 3000.

Next, call the number you purchased using one of your phones. You should hear the introduction message then your second phone should start ringing. Once you answer you should hear your `onAnswer` NCCO message before the call is connected.
