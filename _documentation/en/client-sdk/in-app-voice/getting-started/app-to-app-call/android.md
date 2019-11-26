---
title: Android
language: android
---

# How to Make and Receive In App calls with the Nexmo Client SDK on Android

In this tutorial you learn how to use the Nexmo Client SDK for Android, in order to perform an in-app (IP to IP) voice call.

You create a simple app that can make a call and receive a call.

The app will have two buttons, which log in different users: Jane or Joe. After logging in, Jane and Joe are able to place a call and perform actions such as answer, reject or hangup.

## Prerequisites

1. [Create a Nexmo Application](/tutorials/client-sdk-generate-test-credentials).

2. [Create two users](/tutorials/client-sdk-generate-test-credentials) on that Nexmo Application: one with the name `Jane` and the other with the name `Joe`.

## The starter project

```partial
source: _partials/client-sdk/voice/android/clone-repo.md
```

1. Make sure that `enabledFeatures` array contains `Features.IN_APP_to_IN_APP`. You can remove the rest, if you haven't completed their tutorials yet.

2. Replace the user IDs and tokens:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/two-users-keys'
frameless: false
```

## Login

```partial
source: _partials/client-sdk/voice/android/login-intro.md
```

Open `LoginActivity`. It already has two button handlers: `onLoginJaneClick(...)` and `onLoginJoeClick(...)`.  Each calls the ` loginToSdk(...)` method, with a different parameter - the corresponding `jwt`.

```partial
source: _partials/client-sdk/voice/android/login-code.md
```

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/login'
frameless: false
```

At this point you should already be able to run the app and see that you can login successfully with the SDK.

## Start a Call

You can now make a simple In-App call. If you logged in as Jane, you can call Joe, and if you logged in as Joe you can call Jane.

Open `MainActivity` and complete the prepared `onInAppCallClick()` handler:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/click-call-app'
frameless: false
```

When the call creation is successful, save the `NexmoCall` on `NexmoHelper`, for convenience, and start `OnCallActivity`:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/start-call-activity'
frameless: false
```

You can also start a call with customized logic [using an NCCO](/client-sdk/in-app-voice/concepts/ncco-guide), by choosing `NexmoCallHandler.SERVER` as the `CallHandler`:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/call-handler-server'
frameless: false
```

This allows you to start a PSTN phone call, by adding a phone number to the `callees` list.

## Register for incoming events

When Jane calls Joe, Joe should be notified. Joe can then answer the call. Joe should register to incoming events, and implement `onIncomingCall()`. Whenever Joe is called, `onIncomingCall()` is invoked with the incoming Call object.

For simplicity in this example, you will accept incoming calls only on `MainActivity`. Open `MainActivity` and create the `NexmoIncomingCallListener` to save the reference to the incoming call on `NexmoHelper`, and start `IncomingCallActivity`:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/start-incoming-call-activity'
frameless: false
```

You need to register and deregister the listener in `onCreate()` and `onDestroy()`:

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

Congratulations!  You have implemented your first In-App Voice application with Nexmo Client SDK for Android.

You can now run the app on two devices, log in as two different users, and start an in-app voice call between the users.
