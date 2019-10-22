---
title: JavaScript
language: javascript
---

## Overview

This guide covers the functionalities in your Nexmo Client application, in order to make and receive in-app voice calls.

Before you begin, make sure you [added the SDK to your app](/client-sdk/setup/add-sdk-to-your-app).

## Start a call

This method allows you to conduct in-app calls as well as phone calls while taking advantage of the rich [Nexmo Voice API features](/voice/voice-api/overview).

When your client app calls this method, the `answer_url` webhook that is configured for your [Nexmo Application](/concepts/guides/applications) will execute. That defines the [logic and capabilities](/voice/voice-api/ncco-reference) of the call.

On the client side, start the call as such:

```javascript
new NexmoClient()
    .login(USER_JWT)
    .then(application => {
        ...
        application.callPhone();
    })
```

### Receive incoming call events

To receive an incoming in-app call, you should listen to incoming call events:

```javascript
...
application.on("member:call", (member, call) => {
    ...
```

The listener method receives a `member` object that contains information about the caller and a `call` object, that lets you interact with the call in progress. With the later, you’ll be able to perform methods such as answer, reject and hang up.

### Answer

```javascript
call.answer();
```

### Reject

```javascript
call.reject();
```

### Hang Up

```javascript
call.hangUp();
```

### Listen For Call Status Events

To see updates on the state of the call and its members:

```javascript
application.on("call:status:changed",(call) => {
    ...
});
```