---
title: Add a Call whisper to an inbound call
products: voice/voice-api
description: "Phone numbers are everywhere in advertising: on billboards, in TV ads, on websites, in newspapers. Often these numbers all redirect to the same call center, where an agent needs to inquire why the person is calling, and where they saw the advert. Call Whispers make this so much simpler."
languages:
    - Node
---

# Voice - Add a Call whisper to an inbound call

Phone numbers are everywhere in advertising: on billboards, in TV ads, on websites, in newspapers. Often these numbers all redirect to the same call center, where an agent needs to inquire why the person is calling, and where they saw the advert.

Using call whispers, the context of the incoming call is announced to the call center operator before being connected to the caller. This tutorial will show an application that implements this approach. A user will call one of two numbers. The application answers the call and the caller hears a holding message. Meanwhile, the application also makes a call to the call center operative, plays a different call whisper depending on which number was dialled, and then connects the operative to the conference with the incoming caller.

The examples are written in NodeJS with express, and you can find the code [on Github](https://github.com/Nexmo/node-call-whisper).

## In this tutorial

You will see how to build add a Call Whisper to an inbound call:

* [How it works](#how-it-works) - an overview of who is calling who and how the process flows throughout the example application.
* [Before you begin](#before-you-begin) - set up the application and numbers needed for this tutorial.
* [Getting started with code](#gettings-started-with-code) - clone the repository and get the application running.
* [Code walkthrough](#code-walkthrough) - dive in to the finer points of how the application works.
* [Further reading](#further-reading) - check out some other resources that you might find helpful.

## How it works

```js_sequence_diagram
User->Nexmo number: User calls either of\nthe numbers linked\n to this Application
Nexmo number->Application: /answer_inbound
Application->Conference: Adds user\nto Conference
Application-->Operative: Calls call center operative
Note left of Operative: When operative\nanswers
Operative-->Application: /answer_outbound
Application-->Operative: Announces info related to incoming number
Application-->Conference: Adds operative\nto conference
Note right of Conference: Both participants\nnow in conference
```

## Before you begin

Before we grab and run the code, there are a few things we need to do first.

### Sign up for Nexmo

[Sign up for a Nexmo account](https://nexmo.com) if you don't have one already.

### Set up the CLI

This tutorial uses the [Nexmo command line tool](https://github.com/Nexmo/nexmo-cli), so check it is installed before proceeding.


### Buy two phone numbers

You will want two phone numbers in order to observe different whispers when calling different numbers. Run this command twice and make a note of the numbers that you have bought:

```bash
$ nexmo number:buy --country_code US --confirm
```

### Create an application

Create a new nexmo application and save the private key - you'll need this later. Replace `https://example.com` with the URL of your own application for both the "answer" and "event" arguments in this command:

```bash
nexmo app:create "Call Whisper" https://example.com/answer_inbound https://example.com/event --keyfile app.key
```

This command grabs the private key and puts it safely in `app.key` for you. Make a note of the application ID as it's used in the next command...

### Link numbers to your application

Link the application to both numbers, by running the command below once for each number:

```bash
nexmo link:app [NEXMO_NUMBER] [APP_ID]
```

> You can get a list of apps or numbers at any time with the `nexmo app:list` and `nexmo number:list` commands respectively.

## Getting started with code

The code for this project is on GitHub at <https://github.com/Nexmo/node-call-whisper>. This consists of a NodeJS project using Express and is intended to give you a working example that you can then adapt for your own needs.

### Clone the repository

Either clone or download the repository to your local machine, in a new directory.

### Configure the settings

Your application will need to know more about you and your application before it can run. Copy the `.env-example` file to `.env` and edit this new file to reflect the settings you want to use:

* `NEXMO_API_KEY`: Find this on your [Nexmo Dashboard](https://dashboard.nexmo.com)
* `NEXMO_API_SECRET`: Find this on your [Nexmo Dashboard](https://dashboard.nexmo.com)
* `NEXMO_APP_ID`: The application ID you just created
* `NEXMO_APP_FILE_NAME`: The file holding the private key (`app.key` in the example above)
* `CALL_CENTER_NUMBER`: The phone number to reach the call center operative on, such as your mobile number
* `INBOUND_NUMBER_1`: One of the numbers you purchased
* `INBOUND_NUMBER_2`: The other number you purchased
* `DOMAIN`: The domain name of where your app will be running, for example mine is: `ff7b398a.ngrok.io`

### Install the dependencies

In the directory where you downloaded the code, run `npm install`. This brings in Express, the Nexmo library, and other dependencies needed for this project.

### Start the server

With the configuration done and the dependencies in place, your application is ready to go! Run it with:

`npm start`

By default the application runs on port 5000. If you're going to be using `ngrok`, you can start your tunnel now.

> When the ngrok tunnel name changes, remember to update your application's URLs with the `nexmo app:update` command.

## Try it out

Let's try the demo. For this you need two phones (one to be the "caller" and one to be the "call centre operative") so you may need to recruit a friend or use Skype to make the first call.

1. Call one of the numbers you purchased.
2. The caller will hear a greeting message, and then the call center operative's phone number will ring.
3. When the call center operative answers, they will hear the "whisper" message before they are connected to the original caller.
4. Now try that again but call the other number and listen to the different "whisper".

## Code walkthrough

The demo is fun but if you're interested in building this yourself, then there are some key points that you probably want to see. This section looks at the key sections of the code for each step of the process so that you can find where things take place and can adapt this application to suit your needs.

This NodeJS example uses the [Nexmo NodeJS library](https://github.com/Nexmo/nexmo-node), which is initialized before it is used:

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

### Answer the incoming call, and start an outbound call

Whenever someone calls one of the numbers that are linked to the Nexmo application, Nexmo will receive an incoming call. Nexmo will then notify your web application of that call. It does this by making a [webhook request](/api/voice#cc_answer_webhook) to your web app's `answer_url` endpoint - in this case `/answer_incoming`. When the call is answered, the application starts the outgoing call to the call center operative.

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

When we start this outgoing call, we specify an "Answer URL" for it too. This URL will receive the answer webhook when this second call is answered, and the application includes information about which conference this call will join when that happens.

### Place the caller into a conference

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

### Play a Whisper and join the conference

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

> *Note*: Take a look at the [NCCO reference](/voice/guides/ncco-reference) for information on other actions available.

## Further reading

* <https://github.com/Nexmo/node-call-whisper> contains all the code for this example application.
* Check our our [Voice Guides](/voice) for more things you can do with voice.
* The [Voice API Reference](/api/voice) has detailed documentation for each endpoint.
