---
title: JavaScript
language: javascript
---

# How to Add the Nexmo Client SDK to your JavaScript App

This tutorial shows you how to add the Nexmo Client SDK to your client-side JavaScript app.

## Prerequisites

The Nexmo Client SDK requires [Node.js](https://nodejs.org) and [npm](https://www.npmjs.com/).

## To add the Nexmo Client SDK to your project

### Navigate to your app

Open your terminal. If you have an existing app, navigate to its root. Otherwise, create a new directory for your project and add a default `package.json` by running:

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

If your application will run on a single page, you can load the module in your HTML using a script tag:

```
<script src="./node_modules/nexmo-client/dist/conversationClient.js"></script>
```

Be sure to check that the path to `conversationClient.js` is correct for your project structure.

## Using the Nexmo Client SDK in your app

### Creating Users and JWTs

A JSON Web Token (JWT) is necessary to log in to your Nexmo Application. The Client SDK cannot manage users nor generate JWTs, so you must choose a method of handling it on the backend:

- For onboarding or testing purposes, you can get your client-side app working before setting up a backend by [generating a test JWT from the command line](/tutorials/client-sdk-generate-test-credentials) and hard-coding it in your client-side JavaScript.
- For real world usage, you can deliver JWTs from the server using the Node or PHP [backend SDKs](/tools), and set the `jwt` variable in your code by fetching that data:

    ```javascript
    fetch('/getJwt')
      .then(results => results.json())
      .then(data => {
        jwt = data.token;
      })
      .catch(err => console.log(err));
    ```
- Read more on generating JWTs [in this article](/client-sdk/concepts/jwt-acl)

### Instantiate and log in the ConversationClient

No arguments are necessary to instantiate a new `ConversationClient`, but you will need to pass your JWT as the argument to `login()`.

```javascript
let nexmo = new ConversationClient()
  .login(jwt)
  .then(app => console.log('Logged in to app', app))
  .catch(err => console.log(err));
```

## Conclusion

You added the Nexmo Client SDK to your client-side JavaScript app and logged in to a `ConversationClient` instance, which returned an `Application` object. You can now use `Application.newConversation()` to create a conversation, and then access the functionality of a `Conversation`.