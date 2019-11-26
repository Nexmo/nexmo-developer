---
title: Android
language: android
---

## Overview

This guide covers the functionalities in your Nexmo Client application, in order to make and receive in-app voice calls.

Before you begin, make sure you [added the SDK to your app](/client-sdk/setup/add-sdk-to-your-app).

## Start a call

### Start an In-App Call

The quickest way to start an in-app call is by conducting an in-app to in-app call, meaning between two users.

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/guides/start-and-receive-in-app-calls-android/start-call'
frameless: false
```

The possible voice capabilities are very limited, as this doesn’t utilize [Nexmo Voice API](/voice/voice-api/overview). This method is recommended mostly for onboarding. Later, it is recommended to use a server managed call.

### Start a Server Managed Call

This method allows you to conduct in-app calls as well as phone calls while taking advantage of the rich [Nexmo Voice API features](/voice/voice-api/overview).

When your client app calls this method, the `answer_url` webhook that is configured for your [Nexmo Application](/concepts/guides/applications) will execute. That defines the [logic and capabilities](/voice/voice-api/ncco-reference) of the call.

On the client side, start the call as such:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/guides/start-and-receive-in-app-calls-android/start-server-call'
frameless: false
```

### Receive incoming call

In order to receive an incoming in-app call, you should register and listen to incoming call events:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/guides/start-and-receive-in-app-calls-android/receive-call'
frameless: false
```


Then, you’ll be able to perform methods such as answer and hang up.

### Answer

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/guides/start-and-receive-in-app-calls-android/answer'
frameless: false
```

### Hang Up

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/guides/start-and-receive-in-app-calls-android/hangup'
frameless: false
```

### Listen For Call Events

To see updates on the state of the call member, for example, to know if the other member answered or hung up the call, you should listen to Call events.

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/guides/start-and-receive-in-app-calls-android/listen-to-call-events'
frameless: false
```
