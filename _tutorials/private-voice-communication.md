---
title: Private voice communication
products: voice/voice-api
description: Protect user's number privacy by connecting users together for private voice communication.
languages:
    - Node
---

# Private voice communication

For marketplace scenarios such as food delivery or taxi and passenger communications, it is useful for users to be able to communicate with one another without exposing their phone numbers. By implementing private communication with Nexmo's Voice API you ensure that your users cannot bypass the required or preferred communication workflows and audits.


This tutorial is based on the [Private Voice Communication](https://www.nexmo.com/use-cases/private-voice-communication/) use case. You can download the code from <https://github.com/Nexmo/node-voice-proxy>.


## In this tutorial

You see how to build an Voice proxy for private communication system using [Nexmo CLI](https://github.com/nexmo/nexmo-cli) and [Nexmo Node.JS](https://github.com/Nexmo/nexmo-node)

* [Create a Voice application](#create-a-voice-application) - create and configure an application using [Nexmo CLI](https://github.com/nexmo/nexmo-cli), then configure the webhook endpoints to provide NCCOs and handle changes in Call status
* [Provision virtual numbers](#provision-virtual-voice-numbers) - rent and configure the voice enabled virtual numbers to mask real numbers
* [Create a Call](#create-a-call) - create a Call between two users, validate their phone numbers and determine the country the phone number is registered in using Number Insight
* [Handle inbound calls](#handle-inbound-calls) - configure your webhook endpoint to handle incoming voice calls, find the phone number it is associated with and return the NCCO to control the Call
* [Proxy the Call](#proxy-the-call) - instruct Nexmo to make a private Call to a phone number

## Prerequisites

In order to work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* The [Nexmo CLI](https://github.com/nexmo/nexmo-cli) installed and configured

## Create an application

A Nexmo application contains the security and configuration information you need to connect to Nexmo endpoints and easily use our products. You make requests to Nexmo endpoints using the security information in the application. When you make a Call, Nexmo sends and retrieves call management information with your webhook endpoints.

You first use Nexmo CLI to create an application for Voice API:
```sh
› nexmo app:create voice-proxy https://example.com/proxy-call https://example.com/event
```
This command returns the UUID (Universally Unique Identifier) that identifies your application.

The parameters are:

* voice-proxy - the name you give to this application
* `https://example.com/proxy-call` - when you receive an inbound call to your virtual number, Nexmo makes a GET request and retrieves the NCCO that controls the call flow from this webhook endpoint
* `https://example.com/event` - as the call status changes, Nexmo sends status updates to this webhook endpoint

Then start your Web server:

```js
"use strict";

var express = require('express');
var bodyParser = require('body-parser');

var app = express();
app.set('port', (process.env.PORT || 5000));
app.use(bodyParser.urlencoded({ extended: false }));

var config = require(__dirname + '/../config');

var VoiceProxy = require('./VoiceProxy');
var voiceProxy = new VoiceProxy(config);

app.listen(app.get('port'), function() {
  console.log('Voice Proxy App listening on port', app.get('port'));
});
```

If you're developing behind a firewall or a NAT, use [ngrok](https://ngrok.com/) to tunnel access to your Web server.

## Provision virtual numbers

Virtual numbers are used to hide real phone numbers from your application users.

The workflow diagram below shows the process for provisioning and configuring a virtual number.

```js_sequence_diagram
Participant App
Participant Nexmo
Participant UserA
Participant UserB
Note over App,Nexmo: Initialization
App->Nexmo: Search Numbers
Nexmo-->App: Numbers Found
App->Nexmo: Provision Numbers
Nexmo-->App: Numbers Provisioned
App->Nexmo: Configure Numbers
Nexmo-->App: Numbers Configured
```

To provision a virtual number you search through the available numbers that meet your criteria. For example, a phone number in a specific country with voice capability:

```code
source: '_code/voice_proxy.js'
from_line: 2
to_line: 47
```

Then rent the numbers you want and associate them with your application. When any even occurs relating to each number associated with an application, Nexmo sends a request to your webhook endpoint with information about the event. After configuration you store the phone number for later user.

```code
source: '_code/voice_proxy.js'
from_line: 48
to_line: 79
```

You now have the virtual numbers you need to mask communication between your users.

**Note**: in a production application you choose from a pool of virtual numbers. However, you should keep this functionality in place to rent additional numbers on the fly.

## Create a Call

The workflow to create a Call is:

```js_sequence_diagram
Participant App
Participant Nexmo
Participant UserA
Participant UserB
Note over App,Nexmo: Conversation Starts
App->Nexmo: Basic Number Insight
Nexmo-->App: Number Insight response
App->App: Map Real/Virtual Numbers\nfor Each Participant
App->Nexmo: SMS to UserA
Nexmo->UserA: SMS
App->Nexmo: SMS to UserB
Nexmo->UserB: SMS
```

The following call:

* [Validates the phone numbers](#validate-phone-numbers)
* [Maps phone numbers to real numbers](#map-phone-numbers)
* [Sends an confirmation SMS](#send-confirmation-sms)

```code
source: '_code/voice_proxy.js'
from_line: 89
to_line: 103
```

### Validate the phone numbers

When your application users supply their phone numbers use Number Insight to ensure that they are valid. You can also see which country the phone numbers are registered in:

```code
source: '_code/voice_proxy.js'
from_line: 104
to_line: 114
```

### Map phone numbers to real numbers

Once you are sure that the phone numbers are valid, map each real number to a [virtual number](#provision-virtual-voice-numbers) and save the call:

```code
source: '_code/voice_proxy.js'
from_line: 115
to_line: 149
```

### Send a confirmation SMS

In a private communication system, when one user contacts another, he or she calls a virtual number from their phone.

Send an SMS to notify each conversation participant of the virtual number they need to call:

```code
source: '_code/voice_proxy.js'
from_line: 150
to_line: 171
```

The users cannot SMS each other. To enable this functionality you need to setup [Private SMS communication](/tutorials/private-sms-communication).

In this tutorial each user has received the virtual number in an SMS. In other systems this could be supplied using email, in-app notifications or a predefined number.

## Handle inbound calls

When Nexmo receives an inbound call to your virtual number it makes a request to the webhook endpoint you set when you [created a Voice application](#create-a-voice-application).

```js_sequence_diagram
Participant App
Participant Nexmo
Participant UserA
Participant UserB
Note over UserA,Nexmo: UserA calls UserB's\nVirtual Number
UserA->Nexmo: Calls virtual number
Nexmo->App:Inbound Call(from, to)
```

Extract `to` and `from` from the inbound webhook and pass them on to the voice proxy business logic.

```js
app.get('/proxy-call', function(req, res) {
  var from = req.query.from;
  var to = req.query.to;

  var ncco = voiceProxy.getProxyNCCO(from, to);
  res.json(ncco);
});
```

## Reverse map real phone numbers to virtual numbers

```js_sequence_diagram
Participant App
Participant Nexmo
Participant UserA
Participant UserB
UserA->Nexmo:
Nexmo->App:
Note right of App:Find the real number for UserB
App->App:Number mapping lookup
```

Now you know the phone number making the call and the virtual number of the recipient, reverse map the inbound virtual number to the outbound real phone number.

The call direction can be identified as:

* The `from` number is UserA real number and the `to` number is UserB virtual number
* The `from` number is UserB real number and the `to` number is UserA virtual number

```code
source: '_code/voice_proxy.js'
from_line: 172
to_line: 206
```

With the number looking performed all that's left to do is proxy the call.

## Proxy the Call

Proxy the call to the phone number the virtual number is associated with. The `from` number is always the virtual number, the `to` is a real phone number.

```js_sequence_diagram
Participant App
Participant Nexmo
Participant UserA
Participant UserB
UserA->Nexmo:
Nexmo->App:
App->Nexmo:Connect (proxy)
Note right of App:Proxy Inbound\ncall to UserB's\nreal number
Nexmo->UserB: Call
Note over UserA,UserB:UserA has called\nUserB. But UserA\ndoes not have\n the real number\nof UserB, nor\n vice versa.
```

In order to do this, build up an NCCO (Nexmo Call Control Object). This NCCO uses a `talk` action to read out some text. When the `talk` has completed, a `connect` action forwards the Call to a real number.

```code
source: '_code/voice_proxy.js'
from_line: 6
to_line: 25
```

> **Note**: take a look at the [NCCO reference](/voice/guides/ncco-reference) for more information.

The NCCO is returned to Nexmo by the web server.

```js
app.get('/proxy-call', function(req, res) {
  var from = req.query.from;
  var to = req.query.to;

  var ncco = voiceProxy.getProxyNCCO(from, to);
  res.json(ncco);
});
```

## Conclusion

And that's it. You have built a voice proxy for private communication. You provisioned and configured phone numbers, performed number insight, mapped real numbers to virtual numbers to ensure anonymity, handled an inbound call and proxied that call to another user.
