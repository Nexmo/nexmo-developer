---
title: iOS
language: ios
---

# How to Make Phone Calls with the Nexmo Client SDK on iOS

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

## The Starter Project

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/outbound-pstn-ios/started-project'
```

## Login

Using the Nexmo Client SDK should start with logging in to `NexmoClient`, using a `jwt` user token.

In production apps, your server would authenticate the user, and would return a [correctly configured JWT](/client-sdk/concepts/jwt-acl) to your app.

For testing and getting started purposes, you can use the Nexmo CLI to [generate JWTs](/tutorials/client-sdk-generate-test-credentials).

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/outbound-pstn-ios/login'
```

At this point you should already be able to run the app and see that you can login successfully with the SDK.

## Start a call

You can now make an App-to-Phone call.

The `Call` button press is already connected to `ViewController`.

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/outbound-pstn-ios/start-call'
```

You are expected to replace `CALLEE_PHONE_NUMBER` with the number to be called. But, ultimately, the number that is actually called is the one supplied in the `Answer URL` webhook. In a real-life use case, you would create a server component to serve as the `Answer URL`. The app will send to your backend, through the `Answer URL` the `CALLEE_PHONE_NUMBER`, the backend would validate it and then supply it in the JSON returned.

> **Note:** Whilst the default HTTP method for the `Answer URL` is `GET`, `POST` can also be used.

### Call Type

Note the use of `NXMCallTypeServer` as the `callType` in the `client`'s `call:` method above; this specifies that the logic of the call is defined by the server - a requirement for outbound PSTN calls.

 The other `callType` is `NXMCallTypeInApp`, useful for making simple calls as shown in [this tutorial](/tutorials/client-sdk-ios-in-app-calling).

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/outbound-pstn-ios/call-type'
```

## Call Delegate

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/outbound-pstn-ios/call-delegate'
```

The `statusChanged:` method notifies on changes that happens to members on the call.  

## Hangup a call

Once the "End Call" button is pressed, it is time to hangup the call.

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/outbound-pstn-ios/hangup'
```

Updates for `callMember` statuses are received in `statusChanged` as part of the `NXMCallDelegate` as you have seen before.  

The existing implementation for `statusChanged:` is already handling call hangup.

## Handle permissions

For the call to happen, `Audio Permissions` are required. In the `appDelegate` of the sample project, you can find an implementation for the permissions request in `application:didFinishLaunchingWithOptions`.  

To read more about the permissions required, [see the setup tutorial](/tutorials/client-sdk-ios-add-sdk-to-your-app#add-permissions).

## Conclusion

You have implemented your first App to Phone Voice application with the Nexmo Client SDK for iOS.

Run the app on a simulator and see that you can place and hangup a call to a PSTN phone number from the phone number associated with your Nexmo application.

If possible, test on a device using your developer signing and provisioning facility.
