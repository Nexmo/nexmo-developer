---
title: Call tracking
products: voice/voice-api
description: We live in a world of data and analytics where we use unique identifiers to measure the impact of past decisions in order to fine tune future ones. You can use phone numbers in this way too. For example, you track the most popular phone numbers used for television radio, magazine, print or online advertising, and the times those phone numbers are used, in order to improve future campaigns.
languages:
    - Node
---

# Call tracking

We live in a world of data and analytics where we use unique identifiers to measure the impact of past decisions in order to fine-tune future ones. You can use phone numbers in this way too. For example, you track the most popular phone numbers used for television, radio, magazine, print or online advertising, and the times those phone numbers are used, in order to improve future campaigns.

This tutorial is based on the [Call Tracking](https://www.nexmo.com/use-cases/call-tracking/) use case. You download the code from <https://github.com/Nexmo/node-call-tracker>.

## In this tutorial

In this tutorial you see how to build an application that keeps track of inbound calls using Nexmo APIs and libraries:

* [Create a Voice Application](#create-a-voice-application) - create and configure an application using [Nexmo CLI](https://github.com/nexmo/nexmo-cli), then configure the webhook endpoints to provide NCCOs and handle changes in Call status
* [Buy phone numbers](#provision-virtual-voice-numbers) - Buy phone numbers you use to mask real user numbers
* [Link the phone numbers to the Nexmo Application](#link-numbers) - configure the voice enabled phone numbers you use to mask user numbers
* [Handle inbound voice calls](#handle-inbound-voice-calls) - configure your webhook endpoint to handle incoming voice calls and track of the popularity of the inbound number
* [Proxy the Call](#proxy-the-call) - instruct Nexmo to make a masked Call to a phone number

## Prerequisites

In order to work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* The [Nexmo CLI](https://github.com/nexmo/nexmo-cli) installed and set up
* A publicly accessible web server so Nexmo can make webhook requests to your app. If you're developing locally we recommend [ngrok](https://ngrok.com/).

## Create a Voice application

A Nexmo application contains the security and configuration information you need to connect to Nexmo endpoints and easily use our products. You make calls to a Nexmo product using the security information in the application. When you make a Call Nexmo communicates with your webhook endpoints so you can manage your call.

You first use Nexmo CLI to create an application for Voice API:

```bash
$ nexmo app:create call-tracker https://example.com/track-call https://example.com/event

Application created: 5523f9df-05bb-4a93-9427-6e43c32449b8
```
This command returns the UUID (Universally Unique Identifier) that identifies your application.

The parameters are:

* `call-tracker` - the name you give to this application
* `https://example.com/proxy-call` - when you receive an inbound call to your Nexmo number, Nexmo makes a [GET] request and retrieves the NCCO that controls the call flow from this webhook endpoint
* `https://example.com/event` - as the call status changes, Nexmo sends status updates to this webhook endpoint

Then start your Web server:

```js
var app = require('express')();
var config = require('../config');

app.set('port', (config.port || 5000));
app.use(require('body-parser').json());

app.listen(app.get('port'), function() {
  console.log('Example app listening on port', app.get('port'));
});
```

If you're developing behind a firewall or a NAT, use [ngrok](https://ngrok.com/) to tunnel access to your Web server.


## Buy Voice Enabled Phone Numbers

For call tracking to work, you need one or more Nexmo numbers to track. Use the [Nexmo CLI](https://github.com/nexmo/nexmo-cli) to buy the phone numbers:

```bash
nexmo number:buy --country_code US --confirm
Number purchased: 15554908975
```

## Link phone numbers to the Nexmo Application

Now link each phone number with the *call-tracker* application. When any event occurs relating to a number associated with an application Nexmo sends a request to your webhook endpoints with information about the event.

```bash
nexmo link:app 15554908975 5555f9df-05bb-4a99-9427-6e43c83849b8
```

## Handle inbound voice calls

When Nexmo receives an inbound call to your Nexmo number it makes a request to the webhook endpoint you set when you [created a Voice application](#create-a-voice-application).

```js_sequence_diagram
Participant App
Participant Nexmo
Participant Caller
Participant Recipient
Note over Caller,Nexmo: Caller calls one of\nthe tracking numbers
Recipient->Nexmo: Calls Nexmo number
Nexmo->App:Inbound Call(from, to)
```

Extract `to` and the `from` from the inbound webhook and pass this to your call tracking logic.

```js
var CallTracker = require('./CallTracker');
var callTracker = new CallTracker(config);

/**
 * Webhook endpoint to handle a call being answered.
 * Return an NCCO to record a call and proxy it to another number.
 */
app.get('/answer', function(req, res) {
  var from = req.query.from;
  var to = req.query.to;

  var ncco = callTracker.answer(from, to);
  return res.json(ncco);
});
```

## Track the Call

The workflow for call tracking is:

```js_sequence_diagram
Participant App
Participant Nexmo
Participant Caller
Participant Recipient
Caller->Nexmo: Calls Nexmo number
Nexmo->App:Inbound Call(from, to)
App->App:Track Call
```

Track the call and keep a count of how many times the `from` phone number has been called.

```js
/**
 * Create a new instance of a CallTracker.
 *
 * @param {Object} config - CallTracker configuration.
 */
function CallTracker(config) {
  this.config = config;

  this.trackedCalls = {};
}

/**
 * Track the call and return an NCCO that proxies a call.
 */
CallTracker.prototype.answer = function (from, to) {
  if(!this.trackedCalls[to]) {
    this.trackedCalls[to] = [];
  }
  this.trackedCalls[to].push({timestamp: Date.now(), from: from});
}
```

## Proxy the Call

Now your application has tracked the call information, proxy the call to the intended recipient. Keep the `from` number the same so the recipient has the correct contact details:

```js_sequence_diagram
Participant App
Participant Nexmo
Participant Caller
Participant Recipient
Caller->Nexmo: Calls Nexmo number
Nexmo->App:Inbound Call(from, to)
App->App:Track Call
Note right of App:Proxy Inbound\ncall to Recipient
App->Nexmo:Call
```

Build a Nexmo Call Control Object (NCCO) that instructs Nexmo to connect the call to another phone number. Keep the `from` number the same for the proxied call.

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
    from: from,
    endpoint: [{
      type: 'phone',
      number: this.config.proxyToNumber
    }]
  };
  ncco.push(connectAction);

  return ncco;
```

> **Note**: take a look at the  [NCCO reference](/voice/guides/ncco-reference) for information.

Your web server provides Nexmo with this NCCO and the Call is proxied to the `to` phone number.

```js
/**
 * Webhook endpoint to handle a call being answered.
 * Return an NCCO to record a call and proxy it to another number.
 */
app.get('/answer', function(req, res) {
  var from = req.query.from;
  var to = req.query.to;

  var ncco = callTracker.answer(from, to);
  return res.json(ncco);
});
```

## Conclusion

And that's it. You have built a call tracking application that enables you to determine the most popular number for inbound calls. To do this you have provisioned and configured numbers, handled an inbound call, stored and tracked the inbound call and proxied that call to another user.
