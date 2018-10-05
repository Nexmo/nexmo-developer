---
title: Call phone from app
products: stitch
description: "Call a phone from an app. This is the minimalistic version."
languages:
    - Node
---

# Intro

This tutorial presents a minimalistic Stitch app that allows you to call a phone directly from your Node app.

## In this tutorial

In this tutorial you see how to build a Stitch application that can call a phone:

1. Install Nexmo Command Line Tool (Beta)
2. Create a Nexmo Application
3. Create a webhook server
4. Install Stitch
5. Create a JWT
6. Create a Stitch app using Node

## Prerequisites

In order to work through this tutorial you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* A publicly accessible web server so Nexmo can make webhook requests to your app. If you're testing locally you can use [ngrok](https://ngrok.com/).

## Install Nexmo Command Line Interface (CLI) Beta

In this tutorial you will use the Nexmo CLI to create your Nexmo application and perform some other housekeeping tasks - you can also perform these operations in the Nexmo Dashboard if you find that easier.

To install the Nexmo CLI:

``` bash
$ npm install -g nexmo-cli@beta
```

You now need to initialize your project directory:

``` bash
$ nexmo setup api_key api_secret
```

This will create a `.nexmorc` file in your home directory. This is required for other command line operations to work correctly.

You can obtain your API key and API secret from your Nexmo dashboard.

## Create a Nexmo Application

To create a Stitch application within the Nexmo platform you execute the following command:

``` bash
$ nexmo app:create "Call phone from App" https://example.com/webhooks/answer https://example.com/webhooks/event --type=rtc --keyfile=private.key
```

This will return an Application UUID:

``` bash
Application created: aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

This is your `NEXMO_APPLICATION_ID`. Make a note of your `NEXMO_APPLICATION_ID` as you will use it when linking a Nexmo number to your application and also when creating a JWT.

The parameters to the `app:create` command are as follows:

* The name of the app "Call phone from App".
* Answer webhook URL that will be called by Nexmo when you make a call.
* Event webhook URL that Nexmo will call back on with details of events.
* The name of the generated private key to be associated with the application.

> **Note:** The actual values you use for the Event webhook URL and the Answer webhook URL will depend on whether you are hosting your webhook server on the web or testing locally using Ngrok.

## Create a webhook server

You now need to create a webhook server that can process webhooks (callbacks on a URL) from Nexmo. As you call into 
the Stitch API or interact with other Nexmo APIs calls are made to the callback URLs you configured for that Nexmo application. In normal use your webhook server will be hosted on the web, but for testing locally you can use [Ngrok](https://ngrok.com).

Webhook server code:

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
      text: "Forwarding you to Tony"
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

const server = app.listen(3000, () => {
  console.log('Express server listening on port %d in %s mode', server.address().port, app.settings.env);
});
```

The above code handles two webhooks. The first is the Events webhook. In the above code the events from Nexmo are simply logged out to the console.

The second webhook handled is the Answer webhook. In this case the code does the following:

1. Extract the `to` number so we can forward the call to the required destination.
2. The from number is set to the Nexmo number in this case, but could be set to some other value.
3. An NCCO is returned. This NCCO forwards the call to the destination number.

## Install Stitch

In the directory where you are keeping the code for your project:

``` bash
npm install nexmo-stitch
```

## Create a JWT

First create a User:

``` bash
$ nexmo user:create name="USER"
```

This will create a user and return a User ID:

``` bash
User created: USR-aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

You will only need the user name to generate the JWT.

Then generate a JWT user your `NEXMO_APPLICATION_ID` and your user's name:

``` bash
USER_JWT="$(nexmo jwt:generate ./private.key sub=USER exp=$(($(date +%s)+86400)) acl='{"paths":{"/v1/users/**":{},"/v1/conversations/**":{},"/v1/sessions/**":{},"/v1/devices/**":{},"/v1/image/**":{},"/v3/media/**":{},"/v1/applications/**":{},"/v1/push/**":{},"/v1/knocking/**":{}}}' application_id=NEXMO_APPLICATION_ID)"
```

You can see the generated JWT using:

``` bash
$ echo USER_JWT
```

Will return the generated JWT (not all of the JWT is shown in order to save space):

``` bash
eyJhbGc...II8B6TbFTvfu4btPtzSHYkzg
```

You will copy and paste the value for the JWT into your app in the next step.

You can validate your JWT at [jwt.io](https://jwt.io).

## Create your Stitch app

You now need to create the code for your Stitch application. In this case the app is very simple - it makes a call to a destination phone number from the app itself.

Here's the complete code:

``` html
<!DOCTYPE html>
<html lang="en">

<head>
  <script src="./node_modules/nexmo-stitch/dist/conversationClient.js"></script>
</head>

<body>

  <form id="call-phone-form">
    <h1>Call Phone</h1>
    <input type="text" name="phonenumber" value="">
    <input type="submit" value="Call" />
  </form>

  <script>

    const USER_JWT = 'eyJhbGc...II8B6TbFTvfu4btPtzSHYkzg';

    class PhoneApp {

      constructor() {
        this.callPhoneForm = document.getElementById('call-phone-form');
        this.setupUserEvents();
        this.createClient();
      }

      createClient() {
        new ConversationClient({ debug: false })
          .login(USER_JWT)
          .then(app => {
            console.log('DEBUG: Logged into app', app);
            this.app = app;

            app.on("member:call", (member, call) => {
              this.call = call;
              console.log("DEBUG: member:call - ", call);
            })

            app.on("call:status:changed", (call) => {
              console.log("DEBUG: call:status:changed - ", call.status);
            })
          })
          .catch(this.errorLogger)
      }

      setupUserEvents() {
        this.callPhoneForm.addEventListener('submit', (event) => {
          event.preventDefault();
          this.app.callPhone(this.callPhoneForm.children.phonenumber.value);
        })
      }

      errorLogger(error) {
        console.log(error);
      }

    }
    new PhoneApp();
  </script>
</body>

</html>
```

The code does the following:

1. A simple form is created with a label and a button for entering submitting the destination number.
2. You set a JWT which you generated in a previous step. In a real-world application you would have some authentication logic to set this for a user.
3. You set up your event handlers so that a call is made when the call button is clicked.
4. This app also logs out some call state changed - specifically `member:call` and `call:status:changed`. Other logic could be added here, but to keep things simple these call state change handlers simply log out information about the call to the console.

## Conclusion

In this tutorial you have seen how to create a minimalistic Stitch app that can call a phone directly. You saw how you could create a Nexmo application and configure it on the command line. You also saw how to create a webhook server, and create a JavaScript app that uses the Stitch JavaScript SDK to call a destination number.

## Resources

* [NCCO Reference](/voice/voice-api/ncco-reference)
* [Connect an inbound call](/voice/voice-api/building-blocks/connect-an-inbound-call)
* [Stitch docs](/stitch)
* [A more advanced tutorial](https://www.nexmo.com/blog/2018/08/21/phone-call-web-browser-nexmo-in-app-voice-vue-js-dr/)