---
title: Click to Call
products: client-sdk
description: Learn how to enable your customers to call you directly from your website.
languages:
    - Node
---

# Let Customers Call You From Your Website

To offer the best service to your customers, you want them to be able to get hold of you quickly and conveniently using methods of communication they are comfortable and familiar with. Rather than make them search your "Contact Us" page for your phone number, why not have a button on your website that will place the call for them?

In this use case, we will imagine that you have a support page on your website. You will add a button that will use the Client SDK to call your Nexmo virtual number and have the call forwarded to a "real" number where you can deal with their support query.

This example uses client-side JavaScript to display the button and make the call and node.js on the back end to authenticate your user and route the call to your chosen number. However, you could use the Client [iOS](/sdk/stitch/ios/) or [Android](/sdk/stitch/android/) SDKs and a similar approach to build a mobile app instead.

All the code is [available on GitHub](https://github.com/nexmo-community/client-sdk-click-to-call)

## Prerequisites

In order to work through this use case you need:

* A [Nexmo account](https://dashboard.nexmo.com/sign-up)
* The [Nexmo CLI](https://github.com/nexmo/nexmo-cli) installed and configured.
* A publicly accessible web server so Nexmo can make webhook requests to your app. If you're developing locally we recommend [ngrok](https://ngrok.com/).

## Get Started

There is some initial set up you need to do before you can start working with the code.

### Clone the repo

Download the source code from GitHub:

```
git clone git@github.com:https://github.com/nexmo-community/client-sdk-click-to-call.git
cd client-sdk-click-to-call
```

### Install the Nexmo CLI

You can perform some of these initial steps by using the [Developer Dashboard](https://dashboard.nexmo.com). However, it's often easier to use the Nexmo CLI and as we'll need it for some later steps, install the Nexmo CLI beta before continuing:

```sh
npm install nexmo-cli@beta 
```

Then, configure the Nexmo CLI with your API key and secret:

```sh
nexmo setup API_KEY API_SECRET
```
### Buy a Nexmo number

You'll need a Nexmo virtual number for your customer to call. You can purchase an available number for your chosen country code using the following CLI command:

```
nexmo number:buy -c GB --confirm
```

Just replace `GB` with your own [country code](https://www.iban.com/country-codes).


## Create an Application

Let's not get confused between the application itself that contains the logic and the Nexmo Application.

A Nexmo Application is a container for security and configuration information. When you create a Nexmo application, you specify some [webhook](https://developer.nexmo.com/concepts/guides/webhooks) endpoints; these are the URLs that your code exposes which must be publicly accessible. When a caller calls your Nexmo number, Nexmo makes an HTTP request to the `answer_url` endpoint you specify and follows the instructions it finds there. If you provide an `event_url` endpoint, Nexmo will update your application about call events which can help you troubleshoot any problems.

To create the Nexmo Application, use the Nexmo CLI to run the command below, replacing `YOUR_SERVER_HOSTNAME` in both URLs with your own server's host name:

```bash
nexmo app:create --keyfile private.key ClickToCall https://YOUR_SERVER_HOSTNAME/webhooks/answer https://YOUR_SERVER_NAME/webhooks/event
```

This command returns a unique Application ID. Copy it somewhere, you will need it later!

The parameters are:

* `ClickToCall` - the name of your Nexmo Application
* `private.key` - the name of the file to store the private key in for authentication. This is downloaded to your application's root directory.
* `https://example.com/webhooks/answer` - when you receive an inbound call to your Nexmo number, Nexmo makes a `GET` request and retrieves the [NCCO](/voice/voice-api/ncco-reference) that tells Nexmo's APIs what to do with the call
* `https://example.com/webhooks/event` - When the call status changes, Nexmo sends status updates to this webhook endpoint

## Link your Nexmo number

You need to tell Nexmo which virtual number this Application uses. Execute the following CLI command, replacing `NEXMO_NUMBER` and `APPLICATION_ID` with your own values:

```
nexmo link:app NEXMO_NUMBER APPLICATION_ID
```

## Create a User

You need to authenticate your user using the Client SDK before they can call your Nexmo number. Create a user called `supportuser` with the following CLI command, which returns a unique ID for the user. You don't need to track that ID in this example, so you can safely ignore the output of this command:

```
nexmo user:create name="supportuser"
```

## Generate a JWT

The Client SDK uses [JWTs](/concepts/guides/authentication#json-web-tokens-jwt) for authentication. Execute the following command to create the JWT, replacing `APPLICATION_ID` with your own Nexmo Application ID. The JWT expires after one day (the maximum lifetime of a Nexmo JWT), after which you will need to regenerate it.

```
nexmo jwt:generate ./private.key sub=supportuser exp=$(($(date +%s)+86400)) acl='{"paths":{"/*/users/**":{},"/*/conversations/**":{},"/*/sessions/**":{},"/*/devices/**":{},"/*/image/**":{},"/*/media/**":{},"/*/applications/**":{},"/*/push/**":{},"/*/knocking/**":{}}}' application_id=APPLICATION_ID
```

## Configure your Application

The sample code uses a `.env` file to store the configuration details. Copy `example.env` to `.env` and populate it as follows:

```
PORT=3000
JWT= /* The JWT for supportuser */
SUPPORT_PHONE_NUMBER= /* The Nexmo Number that you linked to your application */
DESTINATION_PHONE_NUMBER= /* A target number to receive calls on */
```
The phone numbers you provide in `.env` should omit any leading zeroes and include the country code. 

For example (using the GB mobile number `07700 900000`): `447700900000`.

## Try it Out!

Run the following command to install the required dependencies:

```sh
npm install
```

Ensure that your application is accessible to Nexmo's APIs from the public Internet. [You can use ngrok for this](https://www.nexmo.com/blog/2017/07/04/local-development-nexmo-ngrok-tunnel-dr):

```sh
ngrok http 3000
```

Launch the application itself:

```
npm start
```

Visit `http://localhost:3000` in your browser. If everything is configured correctly, you will see the "Acme Inc Support" homepage and a message telling you that `supportuser` is logged in.

Click the "Call Now!" button and after a moment or two you will hear a welcome message and then the number specified in `DESTINATION_PHONE_NUMBER` should ring. Click the "Hang Up" button to terminate the call.

## The Server-Side code

Let's dig into the code to see how this sample works. There are two aspects we need to consider here, the client-side code that authenticates the user and places the call, and the server-side code that manages the call itself.

The server-side code is contained in the `server.js` file. We use the `express` framework to create the server and expose the URLs that the application requires and the `pug` templating engine to create the webpage from the templates in the `views` directory. When the user visits the root of our application (`https://localhost:3000`), we render the initial view defined in `index.pug`.

We provide everything the client needs by serving everything in the `public` directory (the client-side code and stylesheet). To make the Client SDK for JavaScript available to the client code, we serve the appropriate code files from `node_modules` too:

```javascript
const express = require('express');
const app = express();

require('dotenv').config();

app.set('view engine', 'pug');

app.use(express.static('public'))
app.use('/modules', express.static('node_modules/nexmo-client/dist/'));

const server = app.listen(process.env.PORT || 3000);

app.get('/', (req, res) => {
  res.render('index');
})
```

### Providing the JWT

The client will call the `/auth` route to retrieve the correct JWT for the specified user. In this sample we have a single user whose JWT is configured in the `.env` file but in a production application we would want to generate these JWTs dynamically.

```javascript
app.get('/auth/:userid', (req, res) => {
  console.log(`Authenticating ${req.params.userid}`)
  return res.json(process.env.JWT);
})
```

### The answer webhook

When a customer places a call to our Nexmo virtual number, Nexmo's APIs will make a `GET` request to the webhook we specified as our answer URL and expect to retrieve a JSON object (a Nexmo Call Control Object or NCCO) containing an array of actions that instructs Nexmo how to handle the call.

In this instance, we use the `talk` action to read a welcome message and then a `connect` action to route the call to our chosen number:

```javascript
app.get('/webhooks/answer', (req, res) => {
  console.log("Answer:")
  console.log(req.query)
  const ncco = [
    {
      "action": "talk",
      "text": "Thank you for calling Acme support. Transferring you now."
    },
    {
      "action": "connect",
      "from": process.env.NEXMO_NUMBER,
      "endpoint": [{
        "type": "phone",
        "number": process.env.DESTINATION_PHONE_NUMBER
      }]
    }]
  res.json(ncco);
});
```

### The event webhook

Nexmo's APIs make an HTTP request to the event webhook endpoint that we specified when we created the Nexmo Application every time an event relating to the call occurs. Here, we are just outputting that information to the console so we can see what's going on:

```javascript
app.post('/webhooks/event', (req, res) => {
  console.log("EVENT:")
  console.log(req.body)
  res.status(200).end()
});
```

## The Client-Side Code

The client-side code exists in `/public/js/client.js` and executes when the page has finished loading. It is responsible for authenticating the user and placing the call.

### Authenticating the user

The first thing the client code does is fetch the correct JWT for the user from the server so that we can authenticate that user using the Client SDK:

```javascript
  // Fetch a JWT from the server to authenticate the user
  const response = await fetch('/auth/supportuser');
  const jwt = await response.json();

  // Create a new NexmoClient instance and authenticate with the JWT
  let client = new NexmoClient();
  application = await client.login(jwt);
  notifications.innerHTML = `You are logged in as ${application.me.name}`;
```

### Placing the call

When the user clicks the "Call Now!" button, we use the authenticated `application` object's `callServer` method to initiate the call and change the button state:

```javascript
  // Whenever we click the call button, trigger a call to the support number
  // and hide the Call Now button
  btnCall.addEventListener('click', () => {
    application.callServer();
    toggleCallStatusButton('in_progress');
  });
});

function toggleCallStatusButton(state) {
  if (state === 'in_progress') {
    btnCall.style.display = "none";
    btnHangup.style.display = "inline-block";
  } else {
    btnCall.style.display = "inline-block";
    btnHangup.style.display = "none";
  }
}
```

Nexmo's APIs receive an inbound call on our virtual number and make a request to the server's answer URL endpoint to retrieve the NCCO which then forwards the call to our chosen device.

### Terminating the call

The only other thing to do is allow either participant in the Conversation to end the call by clicking the "Hang Up" button. We make that button available when we receive an event that confirms that a call is in progress.

The event receives a `call` object as a parameter which we can use to control the call: in this instance by invoking its `hangup` method to terminate it.

We also need to retrieve the active Conversation from the `call`, so that we can monitor the `member:left` event to determine if either party terminates the call and change the button state in response:

```javascript
  // Whenever a call is made bind an event that ends the call to
  // the hangup button
  application.on("member:call", (member, call) => {
    let terminateCall = () => {
      call.hangUp();
      toggleCallStatusButton('idle');
      btnHangup.removeEventListener('click', terminateCall)
    };
    btnHangup.addEventListener('click', terminateCall);

    // Retrieve the Conversation so that we can determine if a 
    // Member has left and refresh the button state
    conversation = call.conversation;
    conversation.on("member:left", (member, event) => {
      toggleCallStatusButton('idle');
    });
  });
```

## Summary

In this use case you learned how to implement a quick and convenient way for your customer to call you by clicking a button on a web page. Along the way you learned how to create a Nexmo application, link your virtual number to it and create and authenticate users.

## Related resources

* [The complete source code](https://github.com/nexmo-community/client-sdk-click-to-call)
* [Client SDK documentation](/client-sdk/overview)
* [In-app voice documentation](/client-sdk/in-app-voice/overview)
* [Contact center use case](/client-sdk/in-app-voice/contact-center-overview)





