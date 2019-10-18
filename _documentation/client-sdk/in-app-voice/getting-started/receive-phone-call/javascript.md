---
title: JavaScript
language: javascript
---

# How to Receive Phone Calls with the Nexmo Client SDK in JavaScript

In this guide, you'll learn how to forward an incoming phone call from a Nexmo phone number, to an in-app user by implementing a webhook and linking that to a Nexmo application.

You will create a simple app to receive a call. The app will automatically log in a user called Jane. After logging in, Jane is able to receive a call and perform actions such as answer, reject or hangup.

## Nexmo Concepts

```partial
source: _partials/client-sdk/voice/pstn-nexmo-concepts.md
```

## Prerequisites

```partial
source: _partials/client-sdk/voice/pstn-prerequisites.md
```

## Application webhook

```partial
source: _partials/client-sdk/voice/inbound-pstn-application-webhook.md
```

## Link a Nexmo Virtual Number

```partial
source: _partials/client-sdk/voice/link-nexmo-number.md
```

## Adding the Nexmo Client to your application

We'll start with a blank HTML page with three buttons for answering, declining and hanging up a call. Create a minimal `index.html` file, for example:

```html
<html>
  <head>
    <title>Receive Phone Calls</title>
    <script src="./node_modules/nexmo-client/dist/nexmoClient.js"></script>
  </head>
  <body>
    <p id="notification"></p>
    <button type="button" id="answer">Answer</button>
    <button type="button" id="reject">Reject</button>
    <button type="button" id="hangup">Hang Up</button>
    <script>

    </script>
  </body>
</html>
```

We'll need to add the Nexmo Client to our folder, in order to do that we'll install it from NPM first, by running this command in the same folder as your `index.html` file:

```bash
$ npm install nexmo-client --save
```

## Login

```partial
source: _partials/client-sdk/voice/javascript/login.md
```

## Listen for incoming call

When the phone number associated with your Nexmo app receives a call, the application should notify the user `Jane` so that they can decide whether to answer or reject it.

This is done by listening for `member:call` events on the `application` object returned by the `login()` promise.

```javascript
.then(application => {
    notification.textContent = `You've logged in with the user ${application.me.user.name}`;
    application.on("member:call", (member, call) => {
      notification.textContent = `You're receiving a call`;
    })
})
```

The listener method receives an `member` object that contains information about who's calling, and a `call` object, that lets you interact with the call in progress.

## Answer a call

In order to answer a call, you'll have to use the `answer()` method on the call object that you received when the `member:call` event was triggered.

```javascript
application.on("member:call", (member, call) => {
  notification.textContent = `You're receiving a call`;

  document.getElementById("answer").addEventListener("click", () => {
    call.answer();
    notification.textContent = `You're in a call`;
  })
})
```

## Reject a call

In order to reject an incoming call, you'll have to use the `reject()` method on the call object that you received when the `member:call` event was triggered.

```javascript
application.on("member:call", (member, call) => {
  notification.textContent = `You're receiving a call`;
  ...
  document.getElementById("reject").addEventListener("click", () => {
    call.reject();
    notification.textContent = `You rejected the call`;
  })
})
```

## Hangup a call

You can hang up a call after you've answered it by using the `hangUp()` method on the `call` object.

```partial
source: _partials/client-sdk/voice/javascript/hangup.md
```

## Conclusion

You have implemented your first Phone to App Voice application with the Nexmo Client SDK for JavaScript.

Open the webpage in a browser to see that you can answer, reject and hangup a call received on the phone number associated with your Nexmo application. If you've followed along this tutorial, your code should look similar to [this](https://github.com/Nexmo/client-sdk-javascript-receive-phone-calls/blob/master/index.html).
