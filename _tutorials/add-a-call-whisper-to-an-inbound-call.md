---
title: Add a Call whisper to an inbound call
products: voice/voice-api
description: "Phone numbers are everywhere in advertising: on billboards, in TV ads, on websites, in newspapers. Often these numbers all redirect to the same call center, where an agent needs to inquire why the person is calling, and where they saw the advert. Call Whispers make this so much simpler."
languages:
    - Node
---

# Voice - Add a Call whisper to an inbound call

Phone numbers are everywhere in advertising: on billboards, in TV ads, on websites, in newspapers. Often these numbers all redirect to the same call center, where an agent needs to inquire why the person is calling, and where they saw the advert.

Call Whispers make this so much simpler. By combining unique inbound numbers to identify the source of the call, the call center operator can be notified of this information before they are connected to a caller. A call whisper redirects an incoming call from one number to another. When the call redirects, audio is played to the recipient to help identify the purpose of the call, while the caller is kept on hold. In the context of running a marketing campaign, a business could use this to advertise a phone number specific to that campaign. When someone calls the number, the call is forwarded to an existing customer service call centre. The agent answering the call is played a brief text-to-speech message explaining the topic of the call before the caller is connected.

## In this tutorial

You will see how to build add a Call Whisper to an inbound call:

* [Create a Voice Application](#create-a-voice-application) - create a voice application using the Nexmo CLI and configuring answer and event webhook endpoints
* [Buy a Phone Number](#buy-a-phone-number) - buy a phone number for the inbound call
* [Link the Phone Number to a Nexmo Application](#link-the-phone-number-to-a-nexmo-application) - configure the voice enabled phone number to be associated with your Voice Application
* [Create a Web Server](#create-a-web-server) - create a webserver that can handle calls coming in
* [Receive an Inbound Phone Call](#receive-an-inbound-phone-call) - use your webhook endpoint to handle an incoming voice call
* [Make an Outbound Phone Call](#make-an-outbound-phone-call) - call the call center agent
* [Place the caller into a conference](#place-the-caller-into-a-conference) - place the caller into a conference with hold music until an agent becomes available
* [Play a Whisper and join the conference](#play-a-whisper-and-join-the-conference) - inform the call center operator of the source of the inbound call, and then connect them into the conference

## Prerequisites

In order to work through this tutorial you'll need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* The [Nexmo CLI](https://github.com/nexmo/nexmo-cli) installed and set up
* A publicly accessible web server so Nexmo can make webhook requests to your app. If you're developing locally use a tool such as [ngrok](https://ngrok.com/) to help you accept webhooks in your local development environment.
* Some knowledge of Node.js and the [Express](https://expressjs.com/) web framework

## Create a Voice Application

To create a voice application within the Nexmo platform you execute the following command.

```bash
$ nexmo app:create "Call Whisper" https://example.com/answer_inbound https://example.com/event --save app.key
Application created: 5555f9df-05bb-4a99-9427-6e43c83849b8
```

"Call Whisper" is the name of the application and the next parameter is the webhook endpoint that Nexmo will make a request to when a call is made to a number associated with the application. The final parameter is also a webhook endpoint so that Nexmo can inform your application of other events related your Nexmo app.

The output of this command is the Application UUID (Universally Unique IDentifier) and the private key for your app in a new file called `app.key`.

## Buy a Phone Number

For our application to function you need two or more numbers that are placed in adverts. Buy a number as follows using the Nexmo CLI:

```bash
$ nexmo number:buy --country_code US --confirm
Number purchased: 447700900000
```

*Note: Repeat the step above to buy more numbers.*

## Link the Phone Number to a Nexmo Application

Associate the newly purchased numbers with the application we've created. This ensures that our application's webhook endpoints are informed when the number is called or any event takes place relating to the number.

```bash
$ nexmo link:app 447700900000 5555f9df-05bb-4a99-9427-6e43c83849b8
```

*Note: Repeat the step above for each number that you rented and want to associate to this application*

## Create a Web Server

For this tutorial you require a web server to be running.

**lib/server.js**

```js
// load environment variable
// from .env file
require('dotenv').config();

// start a new app
var app = require('./app')

// handle all routes
require('./routes')(app);
```

**lib/app.js**

```js
// create a new express server
var express = require('express');
var app = express();
app.set('port', (process.env.PORT || 5000));

// start the app and listen on port 5000
app.listen(app.get('port'), '127.0.0.1', function() {
  console.log('Listening on port', app.get('port'));
});

module.exports = app;
```

With that the basic server is in place.

## Receive an Inbound Phone Call

Whenever someone calls one of the numbers that are linked to the Nexmo application, Nexmo will receive an incoming call. Nexmo will then notify your web application of that call. It does this by making a webhook request to your web app's `answer_url` endpoint.

For this functionality you should use a [Nexmo client library](/tools). Add the Nexmo client to your application and initialize it with our credentials and application key.

**lib/routes.js**

```js
// load environment variables
require('dotenv').config();

// initialize Nexmo with App credentials
var Nexmo = require('nexmo');
var nexmo = new Nexmo({
  apiKey: process.env['NEXMO_API_KEY'],
  apiSecret: process.env['NEXMO_API_SECRET'],
  applicationId: process.env['NEXMO_APP_ID'],
  privateKey: process.env['NEXMO_APP_FILE_NAME']
});
```

## Make an Outbound Phone Call

When a call is made to the number linked to the voice application the [Answer Webhook](/api/voice#cc_answer_webhook) will be recieved by the app webhook endpoint. When this happens, start a new call to the call center.

**lib/routes.js**

```js
// Set an index for the current conference ID
var conferenceID = 0;

module.exports = function(app){

  // Process an inbound call from an inbound
  // call made to one of the two numbers
  // we've set up
  app.get('/answer_inbound', function(req, res) {
    // increment the conference ID so
    // that every call has a unique conference
    conferenceID++;

    // create a new call from the number called
    // to the call center
    nexmo.calls.create({
      to: [{
        type: 'phone',
        number: process.env['CALL_CENTER_NUMBER']
      }],
      from: {
        type: 'phone',
        number: req.query.to
      },
      // when the second leg of this call is
      // set up we make sure to pass along the
      // conference ID
      answer_url: [
        'http://'+process.env['DOMAIN']+'/answer_outbound?conference_id='+conferenceID
      ]
    }, function(err, suc) {

    })
  })
}
```

*Note: Take a look at the [Voice API reference](/api/voice) for more info.*

## Place the caller into a conference

Once the outbound call has started, your code will need to return an [Nexmo Call Control Object (NCCO)](/voice/guides/ncco) to give instructions to our servers on how to handle the call. The [`talk`](/voice/guides/ncco-reference#talk) action lets you play text-to-speech to the caller to inform them they are being connected.

Then use the [`conversation`](/voice/guides/ncco-reference#conversation) NCCO action to put the caller into a conference. Since the caller is the only participant. This effectively puts them on hold and you can inform Nexmo to play hold music to them using the `musicOnHoldUrl` attribute. This music will stop when the next caller joins the conference.

**lib/routes.js**

```js
}, function(err, suc) {
  console.log("Error:", err);
  console.log("Success:", suc);

  // When the call has been set up successfully
  // we connect the inbound call to a new
  // conference with the ID specified
  if (suc) {
    res.json([
      {
        "action": "talk",
        "text": "Please wait while we connect you"
      },
      // When we connect the inbound call to a conference
      // we keep them on hold and play a ringing sound
      // until the operator is connected
      {
        "action": "conversation",
        "name": "conversation-"+conferenceID,
        "startOnEnter": "false",
        "musicOnHoldUrl": ["https://nexmo-community.github.io/ncco-examples/assets/phone-ringing.mp3"]
      }
    ]);
  }
});
});
```

*Note: Take a look at the [NCCO reference](/voice/guides/ncco-reference) for information on other actions available.*

## Play a Whisper and join the conference

When a new outbound call to the call center agent was started, a new `answer_url` was passed for that call to fetch instructions from. This URL provides Nexmo with another set of instructions. This endpoint identifies which number is related to each advertising campaign.

**lib/routes.js**

```js
// Define the topics for the inbound numbers
var topics = {}
topics[process.env['INBOUND_NUMBER_1']] = 'the summer offer';
topics[process.env['INBOUND_NUMBER_2']] = 'the winter offer';
```

When the call comes in to the call center, play a call whisper to the agent using the `talk` NCCO action, informing them which advertising campaign the call is about, before connecting them to the caller waiting in the conference.

**lib/routes.js**

```js
// Process an outbound call to the call center,
// playing a message to the call center operator
// before connecting them to the conference ID
app.get('/answer_outbound', function(req, res) {
  // we determine the topic of the call
  // based on the inbound call number
  var topic = topics[req.query.from]

  res.json([
    // We first play back a little message
    // telling the call center operator what
    // the call regards to. This "whisper" can
    // only be heard by the call center operator
    {
      "action": "talk",
      "text": "Incoming call regarding "+topic
    },
    // Next we connect the call to the same conference,
    // connecting the 2 parties
    {
      "action": "conversation",
      "name": "conversation-"+req.query.conference_id
    }
  ]);
});
```

> *Note*: Take a look at the [NCCO reference](/voice/guides/ncco-reference) for information on other actions available.*

## Conclusion

You have created a voice application, purchased phone numbers and linked them to a Nexmo voice application. You have then built a Call Whisper application that receives an inbound call, makes an outbound call to an agent, uses text-to-speech for Call Whisper, and uses a conference to hold a user before connecting the agent to the caller.

## Get the Code

All the code for this tutorial and more is in the [Call Whisper repository on GitHub](https://github.com/Nexmo/node-call-whisper).

## Resources

* [Voice Guides](/voice)
* [Voice API Reference](/api/voice)
