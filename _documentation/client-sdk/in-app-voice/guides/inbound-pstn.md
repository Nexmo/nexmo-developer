---
title: Phone to App Calls
description: This topic shows you how to handle an inbound phone call in your app.
navigation_weight: 2
---

# Phone to App Calls

In this guide, we'll learn how to forward an incoming phone call from a Nexmo phone number to an in-app user by implementing a Webhook and linking that to a Nexmo application.

## Before you begin

Before we begin you’ll need a few things:

* [Node.js](https://nodejs.org/en/) installed on your machine</li>
* Create a free Nexmo account - [signup](https://dashboard.nexmo.com)</li>
* Install the Nexmo Beta CLI:

```
$ npm install -g nexmo-cli@beta
```
* Setup the CLI to use your Nexmo API Key and API Secret. You can get these from the <a href="https://dashboard.nexmo.com/settings">setting page</a> in the Nexmo Dashboard:

```
$ nexmo setup api_key api_secret
```



## Forwarding a call to a user

When a user calls a Nexmo virtual phone number associated with a voice application, Nexmo retrieves the Nexmo Call Control Objects (NCCO) from your `answer_url` Webhook endpoint. We'll try to answer the call with a synthesized voice that reads some text and then connects the call onwards to a user. We'll use the NCCO to create the call flow.

### Creating a webhook endpoint

We're going to write the Webhook using Node and [ExpressJS](http://expressjs.com/). If you prefer a different language, feel free to use something else — there are Nexmo client libraries for [JavaScript](https://github.com/nexmo/nexmo-node "Nexmo Node Library"), [Java](https://github.com/nexmo/nexmo-java "Nexmo Java Library"), [Python](https://github.com/nexmo/nexmo-python "Nexmo Python Library"), [PHP](https://github.com/nexmo/nexmo-php "Nexmo PHP Library"), [Ruby](https://github.com/nexmo/nexmo-ruby "Nexmo Ruby Library"), and [.NET](https://github.com/nexmo/nexmo-dotnet "Nexmo DotNet Library")!

We'll need to install a few things:

```
$ npm install express body-parser --save
```

Create an `index.js` file, instantiate express and body-parser, and listen to the server on port 3000.

```javascript
'use strict';
const express = require('express');
const bodyParser = require('body-parser');
const app = express();
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({extended: true}));

const server = app.listen(3000, () => {
  console.log('Express server listening on port %d in %s mode', server.address().port, app.settings.env);
});
```

Let's add an endpoint for `/event` that logs all the events coming from the Nexmo Application:

```javascript
app.post('/event', (req, res) => {
  console.log(req.body);
  res.status(200).end();
});
```

We also need an endpoint for `/answer`, responding to HTTP GET requests, that is going to deliver the NCCO when the Nexmo Application retrieves the `answer_url`. We'll use a `talk` code snippet so the call generates text-to-speech letting the user know they're calling `Jamie`, followed by a `connect` block. Notice that the connect action is using type `app`. This means that the second leg of the call is completed using the In-App channel (via WebRTC) in order to then connect the call with an existing app user. You can add your own phone number in the `from` field.

```javascript
app.get('/answer', (req, res) => {
  var ncco = [
    {
      action: "talk",
      text: "Thank you for calling Jamie"
    },
    {
      "action": "connect",
      "from": "449876543210",
      "endpoint": [
        {
          "type": "app",
          "user": "jamie"
        }
      ]

    }
  ];
  res.json(ncco);
})
```

Now let's run the server:

```
$ node index.js
```

While you're developing, you can run the server locally, and use ngrok to make the server publicly available on the internet, so Nexmo can reach it. We have a [tutorial on how to do that!](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr/ "Set Up Local Development With Ngrok")

Now we'll have to connect the Webhook to a Nexmo Application. I'm going to assume you already have one and show you how to update that application to use the Webhook we just created.

## Update your existing application with Webhook URLs

You need the Application ID to update the information. You can use the `app:list` command with the Nexmo CLI:

```
$ nexmo app:list
```

The CLI should return a list of each app ID and an app name. Now, use the correct app ID to update the application with the webhook URLs:

```
$ nexmo app:update aaaaaaaa-bbbb-cccc-dddd-0123456789ab "My Voice App" https://6e5c2f7a.ngrok.io/answer https://6e5c2f7a.ngrok.io/event
```

Finally, you need to associate your application with the virtual number you rent from Nexmo. Let’s use the Nexmo CLI again. Use the command `nexmo link:app` followed by the phone number, which must start with a country code and then the app ID. So, the command should look like this:

```
$ nexmo link:app 449876543210 aaaaaaaa-bbbb-cccc-dddd-0123456789ab
```

When the linking is successful, the CLI returns with the message, “Number updated”.

## Conclusion

Now that you've linked your number to your application, whenever someone calls your Nexmo number they are going to be connected to a user via In-App Voice. If you want to test this out, you can check out the [Android](/stitch/in-app-voice/guides/calling-users/android) and [iOS](/stitch/in-app-voice/guides/calling-users/ios) guides detailing how you can implement calling using the SDKs.


> Note: Making calls from a phone to an app user via APAC(Asia Pacific) LVNs is unfortunately currently unsupported.
