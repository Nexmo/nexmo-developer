---
title: iOS
language: ios
---

# How to Receive Phone Calls with the Nexmo Client SDK on iOS

In this guide, you'll learn how to receive an incoming phone call in a Nexmo application by implementing a [webhook](/concepts/guides/webhooks) and linking that to a [Nexmo application](/concepts/guides/applications).


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

## The Starter project

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/inbound-pstn-ios/started-project'
```

## Login

Using the Nexmo Client SDK should start with logging in to `NexmoClient`, using a `jwt` user token.

In production apps, your server would authenticate the user, and would return a [correctly configured JWT](/client-sdk/concepts/jwt-acl) to your app.

For testing and getting started purposes, you can use the Nexmo CLI to [generate JWTs](/tutorials/client-sdk-generate-test-credentials).

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/inbound-pstn-ios/login'
```

At this point you should already be able to run the app and see that you can login successfully with the SDK.


## Receive incoming call

When the phone number associated with your Nexmo app receives a call, the app should notify the user `Jane` so that she can decide whether to answer or reject it.

This is done by implementing the optional `client(_:didReceive:)` method which is declared in the `NXMClientDelegate`.

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/inbound-pstn-ios/receive'
```

This method takes as a parameter an `NXMCall` object with which you can answer or reject the call. An alert was implemented for you, to allow the user to choose whether to answer or reject the call.

## Answer a call

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/inbound-pstn-ios/answer'
```

`answer:completionHandler:` accepts an object adopting the `NXMCallDelegate` and a completion block to indicate if an error occurred in the process. You already implemented `NXMCallDelegate` in a previous step.

## Reject a call

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/inbound-pstn-ios/reject'
```

`reject:` accepts a single `completionHandler` parameter to indicate if an error occurred in the process.

## Call Delegate

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/inbound-pstn-ios/call-delegate'
```

The `call(_:didUpdate:with:)` method notifies on changes that happens to members on the call.


## Hangup a call

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/inbound-pstn-ios/hangup'
```


## Handle permissions

For the call to happen, `Audio Permissions` are required. In the `appDelegate` of the sample project, you can find an implementation for the permissions request in `application:didFinishLaunchingWithOptions`.

To read more about the permissions required, [see the setup tutorial](/client-sdk/setup/add-sdk-to-your-app/ios#add-permissions).


## Conclusion

Congratulations! You have implemented your first Phone to App Voice application with the Nexmo Client SDK for iOS.

Run the app on a simulator, and with another device call the nexmo Number you linked. Then, see that you can answer, reject and hangup a call received on the phone number associated with your Nexmo application.

If possible, test the application on a device using your developer signing and provisioning facility.
