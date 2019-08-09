---
title: Call tracking
products: voice/voice-api
description: Keep track of which campaigns are working well by using different numbers for each one and tracking the incoming calls. This tutorial shows you how to handle incoming calls, connect them to another number, and track the phone numbers that called each of your Nexmo numbers.
languages:
    - Node
---

# Track Usage Across Your Nexmo Numbers

Gain insight into the effectiveness of your customer communications by keeping track of the calls received by your Nexmo numbers. By registering a different number for each of your marketing campaigns, you can see which one performs the best and use that information to improve your future marketing efforts.

Today's example uses node.js and all the code is [available on GitHub](https://github.com/Nexmo/node-call-tracker), however the same approach could be used for any other technology stack just as effectively.

## Prerequisites

In order to work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* The [Nexmo CLI](https://github.com/nexmo/nexmo-cli) installed and set up.
* A publicly accessible web server so Nexmo can make webhook requests to your app. If you're developing locally we recommend [ngrok](https://ngrok.com/).

⚓ Create a Voice Application
⚓ Buy Voice Enabled Phone Numbers
⚓ Link phone numbers to the Nexmo Application
## Get Started

Before you grab the code and dive in, you will to set up a Nexmo application and get some numbers to use with it. When you create a Nexmo application, you specify some [webhook](https://developer.nexmo.com/concepts/guides/webhooks) endpoints; these are URLs in your own application and are the reason that your code must be publicly accessible. When a caller calls your Nexmo number, Nexmo will make a web request to the `answer_url` endpoint you specify and follow the instructions it finds there.

There is also an `event_url` webhook, that receives updates whenever the call state changes. To keep things simple, in this application the code simply outputs the events to the console to make them easy to see while developing an application.

To create the initial application, use the Nexmo CLI to run the command below, replacing your URL in two places:

```bash
nexmo app:create --keyfile private.key call-tracker https://your-url-here/track-call https://your-url-here/event
```

This command returns the UUID (Universally Unique Identifier) that identifies your application. Copy it somewhere safe, you will need it later!

The parameters are:

* `call-tracker` - the name you give to this application
* `private.key` - the name of the file to store the private key in, `private.key` is expected by the application
* `https://example.com/track-call` - when you receive an inbound call to your Nexmo number, Nexmo makes a `GET` request and retrieves the NCCO that controls the call flow from this webhook endpoint
* `https://example.com/event` - as the call status changes, Nexmo sends status updates to this webhook endpoint

You will need a couple of Nexmo numbers to try this application. To buy a number, use the Nexmo CLI again and a command like this:

```bash
nexmo number:buy --country_code US --confirm
```

You can use any country code in [ISO 3166-1 alpha-2 format](https://en.wikipedia.org/wiki/ISO_3166-1_alpha-2) for this command. The result is the number you have bought so copy that (you can always get a list with `nexmo numbers:list`) and link it the the application you created:

```bash
nexmo link:app [number] [application ID]
```

Repeat the buying and linking step for as many numbers as you'd like to use.

> For new users, you will need to top up your account before you can buy a number.

## Set Up and Run the Application

Get the code from here: <https://github.com/Nexmo/node-call-tracker>. Either clone the repository to your local machine or download the zip file, it doesn't matter which.

Install the dependencies with this command: `npm install`

Then copy the config template `example.env` to a file called `.env`. In this file you will need to configure the phone number that Nexmo should connect out to, so this can be any phone that you are nearby and can answer.

> You can also set the port number in the `.env` file by adding a `PORT` setting

To start the webserver: `npm start`

Check everything is working as expected by visiting <http://localhost:5000>. You should see "Hello Nexmo" as the response.

## Handle inbound voice calls

When Nexmo receives an inbound call to your Nexmo number it makes a request to the webhook endpoint you set when you [created a Voice application](#get-started).

```js_sequence_diagram
Participant App
Participant Nexmo
Participant Caller
Note over Caller,Nexmo: Caller calls one of\nthe tracking numbers
Caller->Nexmo: Calls Nexmo number
Nexmo->App:Inbound Call(from, to)
```

When the caller makes the call, the application receives the incoming webhook. It extracts the number that the caller is calling from (the `to` number) and the number that they dialled (the `from` number) and passes these values to the call tracking logic.

The incoming webhook is received by the `/track-call` route:

```js
app.get('/track-call', function(req, res) {
  var from = req.query.from;
  var to = req.query.to;

  var ncco = callTracker.answer(from, to);
  return res.json(ncco);
});
```

⚓ Track the Call 
## Track the Call Before Connecting the Caller

The logic for actually tracking the call is separate and super-simple in the example application. Possibly too simple, since it loses the data when you restart the server! For your own applications you may extend this part to write to a database, logging platform, or something else to suit your own needs. After tracking the call, the application returns a [Nexmo Call Control Object (NCCO)](https://developer.nexmo.com/voice/voice-api/ncco-reference) to tell Nexmo's servers what to do next with the call.

You'll find this code in `lib/CallTracker.js`:

```js
/**
 * Track the call and return an NCCO that proxies a call.
 */
CallTracker.prototype.answer = function (from, to) {
  if(!this.trackedCalls[to]) {
    this.trackedCalls[to] = [];
  }
  this.trackedCalls[to].push({timestamp: Date.now(), from: from});
  
  var ncco = [];
  
  var connectAction = {
    action: 'connect',
    from: to,
    endpoint: [{
      type: 'phone',
      number: this.config.proxyToNumber
    }]
  };
  ncco.push(connectAction);
  
  return ncco;
};
```

The NCCO uses the `connect` action to connect the incoming caller with another call to the number you specified in the config file. The `from` number has to be a Nexmo number, so the code uses the tracked number as the caller ID for the outgoing call. Check the [NCCO documentation for the `connect` action](https://developer.nexmo.com/voice/voice-api/ncco-reference#connect) for more detail on the call control object.

## Conclusion

With this approach you have been able to link some Nexmo numbers to your node.js application, make a record of incoming calls to those numbers and connect the callers to an outbound number. By recording the timestamp as well as the from and to numbers, you can go ahead and perform any analysis that you need to on this data to get the best results for your business.

## Where Next?

Here are a few more suggestions of resources that you might enjoy as a next step after this tutorial:

* [Add a call whisper to an inbound call](https://developer.nexmo.com/tutorials/add-a-call-whisper-to-an-inbound-call) to announce some details about the incoming call to the outgoing call before connecting the two.
* Blog post covering how to [Connect your local development server to the Nexmo API using an ngrok tunnel](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/).
* The [Webhooks Reference for Voice](https://developer.nexmo.com/voice/voice-api/webhook-reference) shows the details of incoming webhooks for both `answer_url` and `event_url` endpoints.
* Refer to the [NCCO Documentation](https://developer.nexmo.com/voice/voice-api/ncco-reference) to get details on other actions that you can use to control the flow of your Nexmo calls.
