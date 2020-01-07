---
title: JavaScript
language: javascript
---

## Overview

> **NOTE:** A step-by-step tutorial to making a phone call from a web application is also available [here](/client-sdk/tutorials/app-to-phone/introduction). A step-by-step tutorial on receiving a phone call in your web application is also available [here](/client-sdk/tutorials/phone-to-app/introduction).

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
