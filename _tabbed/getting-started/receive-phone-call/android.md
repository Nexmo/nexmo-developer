---
title: Android
language: android
---

# How to Receive Phone Calls with the Nexmo Client SDK on Android

In this guide, you'll learn how to receive an incoming phone call in an Android application.

You will create a simple Android app, that will  log in a user called Jane. After logging in, Jane is able to receive a call and perform actions such as answer or hangup.

# Nexmo Concepts

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

## The starter project

```partial
source: _partials/client-sdk/voice/android/clone-repo.md
```

1. Make sure that in `enabledFeatures`
you have to `Features.PHONE_to_IN_APP`.
You can remove the rest, if you haven't completed their tutorials yet.

2. Replace the user IDs and tokens:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/single-user-keys'
frameless: false
```

## Login

```partial
source: _partials/client-sdk/voice/android/login-intro.md
```

Open `LoginActivity`. It already has a button handler:`onLoginJaneClick(...)` that calls `loginToSdk(...)` method, with the `jwt` you provided.

```partial
source: _partials/client-sdk/voice/android/login-code.md
```

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/login'
frameless: false
```

At this point you should already be able to run the app and see that you can login successfully with the SDK.

## Receive incoming call

When the phone number associated with your Nexmo app receives a call, the app should notify the user `Jane` so that she can decide whether to answer or reject it.

It is done by registering to incoming events, with `NexmoIncomingCallListener` and implementing `onIncomingCall()`.

For simplicity in this example, you will accept incoming calls only on `MainActivity`. Open `MainActivity` and create the `NexmoIncomingCallListener` to save the reference to the incoming call on `NexmoHelper`, and start `IncomingCallActivity`:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/start-incoming-call-activity'
frameless: false
```

You need to register and unregister the listener in `onCreate()` and `onDestroy()`:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/register-incoming-events'
frameless: false
```

## Answer a call

```partial
source: _partials/client-sdk/voice/android/answer.md
```

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/on-answer'
frameless: false
```

## Hangup

```partial
source: _partials/client-sdk/voice/android/hangup.md
```

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/on-hangup'
frameless: false
```

## Register to call status

```partial
source: _partials/client-sdk/voice/android/call-status.md
```

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/finish-call-listener'
frameless: false
```

## Handle permissions

```partial
source: _partials/client-sdk/voice/android/permissions.md
```

# Conclusion

Congratulations! You have implemented your first Phone to App Voice application with the Nexmo Client SDK for Android.

Run the app on a simulator or a device, and with another device call the Nexmo Number you linked to you application. Then, see that you receive the call, and can answer and hangup.
