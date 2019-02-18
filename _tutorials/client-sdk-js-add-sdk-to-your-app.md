---
title: How to Add the Nexmo Client SDK to your JavaScript App
products: client-sdk
description: This tutorial shows you how to add the Nexmo Client SDK to your JavaScript application.
languages:
    - JavaScript
---

# How to Add the Nexmo Client SDK to your JavaScript App

This tutorial shows you how to add the Nexmo Client SDK to your client-side JavaScript app. 

## Prerequisites

The Nexmo Client SDK requires [Node.js](https://nodejs.org) and [npm](https://www.npmjs.com/).

## To add the Nexmo Client SDK to your project

### Navigate to your app

In your terminal, navigate to the root of your app. If your project does not exist yet, create it now, adding a default `package.json` with:

```
npm init -y
```

### Install the Client SDK package

Install the Nexmo Client SDK from npm:

```
npm install nexmo-client -s
```

### Import the Client SDK into your code

If your app is using ES6 module syntax, you can import the client module near the top of your application code:

```
import ConversationClient from 'nexmo-client';
```

Alternately, if your application will run on a single page, you can load the module in your HTML using a script tag:

```
<script src="./node_modules/nexmo-client/dist/conversationClient.js"></script>
```

Be sure to check that the path to `conversationClient.js` is correct for your project structure.

## Using the Nexmo Client SDK in your app

### Instantiate and log in the ConversationClient

No arguments are necessary to instantiate a new ConversationClient, but you will need to pass a JWT for the user of your app as the argument to `login()`:

```javascript
let nexmo = new ConversationClient()
  .login(jwt)
  .then(app => console.log('Logged in to app', app))
  .catch(err => console.log(err));
```

To get your client-side app working before setting up your backend, you can [generate a test JWT from the command line](https://developer.nexmo.com/tutorials/client-sdk-generate-test-credentials) and hard-code it in your client-side JavaScript. For real world usage, you can deliver JWTs from the server using the [backend SDK](https://developer.nexmo.com/tools) of your choice, and set the `jwt` variable in your code by fetching that data:

```javascript
fetch('/getJwt')
  .then(results => results.json())
  .then(data => {
    jwt = data.token;
  })
  .catch(err => console.log(err));
```

## Conclusion

You added the Nexmo Client SDK to your client-side JavaScript app and logged in to a `ConversationClient` instance, which returned an `Application` object. You can now use `Application.getConversation()` to get a specific conversation, and then use additional functionality.