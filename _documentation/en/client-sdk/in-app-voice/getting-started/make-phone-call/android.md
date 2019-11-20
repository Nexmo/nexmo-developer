---
title: Android
language: android
---

# How to Make Phone Calls with the Nexmo Client SDK on Android

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

## The starter project

```partial
source: _partials/client-sdk/voice/android/clone-repo.md
```

1. Make sure that in `enabledFeatures`
you have to `Features.IN_APP_to_PHONE`.
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

## Start a call

You can now make an App-to-Phone call.

Open `MainActivity` and complete the prepared `onPhoneCallClick()` handler:

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/android/click-call-phone'
frameless: false
```

You are expected to replace `CALLEE_PHONE_NUMBER` with the number to be called. But, ultimately, the number that is actually called is the one supplied in the `Answer URL` webhook. In a real-life use case, you would create a server component to serve as the `Answer URL`. The app will send to your backend, through the `Answer URL` the `CALLEE_PHONE_NUMBER`, the backend would validate it and then supply it in the JSON returned.

> **Note:** Whilst the default HTTP method for the `Answer URL` is `GET`, `POST` can also be used.

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

Run the app on a simulator or a device, and with another device call the Nexmo Number you linked. Then, see that you can answer, reject and hangup a call received on the phone number associated with your Nexmo application.
