---
title: JavaScript
language: javascript
---

# How to Make Phone Calls with the Nexmo Client SDK in JavaScript

```partial
source: _partials/client-sdk/voice/outbound-call-intro.md
```

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
source: _partials/client-sdk/voice/outbound-pstn-application-webhook.md
```

## Adding the Nexmo Client to your application

We'll start with a blank HTML page with two buttons for calling a phone and hanging up a call. Create a minimal `index.html` file, for example:

```html
<html>
  <head>
    <title>Make Phone Calls</title>
    <script src="./node_modules/nexmo-client/dist/conversationClient.js"></script>
  </head>
  <body>
    <p id="notification"></p>
    <button type="button" id="call">Call</button>
    <button type="button" id="hangup">Hang Up</button>
    <script>

    </script>
  </body>
</html>
```

We'll need to add the Nexmo Client to it, in order to do that we'll install it from NPM first, by running this command in the same folder as your `index.html` file:

```bash
$ npm install nexmo-client --save
```

## Login

```partial
source: _partials/client-sdk/voice/javascript/login.md
```

## Make a call

In order to make a call, you'll have to use the `callServer()` method on the application object. The application object is returned by the `login()` promise. The method requires a string as parameter that it passes along to your `answer_url`, but since ours is a static file, we'll leave the method parameter empty. 

> In this example, where you're intending to dial a number, the string is the number you wish to call. It must match the number in the static file you've created.

```javascript
new ConversationClient()
    .login(USER_JWT)
    .then(application => {
        ...
        document.getElementById("call").addEventListener("click", () => {
          application.callServer(callee);
          notification.textContent = `You're calling a phone number`;
        })
    })
    .catch(console.log);
```

## Listen for call events

When the application makes a call, you can start listening for `member:call` events on the application. That's going to return a `call` object, so you can start interacting with the call later on.

```javascript
new ConversationClient()
    .login(USER_JWT)
    .then(application => {
        ...
        application.on("member:call", (member, call) => {
          notification.textContent = `You're receiving a call`;
        })
    })
    .catch(console.log);
```

The listener method receives a `member` object that contains information about who's calling, and a `call` object, that lets you interact with the call in progress.

## Hangup a call

You can hang up a call after you've initiated it by using the `hangUp()` method on the `call` object.

```partial
source: _partials/client-sdk/voice/javascript/hangup.md
```

## Conclusion

You have implemented your first App to Phone Voice application with the Nexmo Client SDK for JavaScript.

Open the webpage in a browser to see that you can make a call and hangup a call to a phone number. If you've followed along this tutorial, your code should look similar to [this](https://github.com/Nexmo/client-sdk-javascript-make-phone-calls/blob/master/index.html).
