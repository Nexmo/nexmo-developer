---
title: iOS
language: ios
---

# How to Make and Receive In App Calls with the Nexmo Client SDK on iOS

In this tutorial you learn how to use the Nexmo Client SDK for iOS, in order to perform an in-app (IP to IP) voice call.

You will create a simple app to make a call and receive a call.

The app will have two buttons, which log in different users: Jane or Joe. After logging in, Jane and Joe are able to place a call and perform actions such as answer, reject or hangup.


## Prerequisites

- Use an existing Nexmo Application or [create a new one](/tutorials/client-sdk-generate-test-credentials).

- Have at least two users or [create them](/tutorials/client-sdk-generate-test-credentials#create-a-user) for your Nexmo Application, with [valid JWTs](/tutorials/client-sdk-generate-test-credentials).


## Starter Project

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/in-app-calling-ios/started-project'
```


## Login

Using the Nexmo Client SDK should start with logging in to `NexmoClient`, using a user's `jwt`.

In production apps, your server would authenticate the user, and would return a [correctly configured JWT](/client-sdk/concepts/jwt-acl) to your app.

For testing and getting started purposes, you can use the Nexmo CLI to [generate JWTs](/tutorials/client-sdk-generate-test-credentials).

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/in-app-calling-ios/login'
```

At this point you should already be able to run the app and see that you can login successfully with the SDK.


## Start a Call

You can now make a simple In-App call. If you logged in as Jane, you can call Joe, and if you logged in as Joe you can call Jane - the call button changes its text accordingly.

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/in-app-calling-ios/start-call'
```


### Call Handler

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/in-app-calling-ios/call-type'
```

This also allows you to start a PSTN phone call, by adding a phone number as the `callee`.



### Call Delegate

Note that, when a call is placed successfully, we're setting `self` as the delegate for it.  

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/in-app-calling-ios/call-delegate'
```

You can build the project now and make an outgoing call. Next you implement how to receive an incoming call.


## Receive incoming call

When Jane calls Joe, Joe should be notified, so that he can decide on answering or rejecting the call.

This is done by implementing the optional `client(_:didReceive:)` method which is declared in the `NXMClientDelegate`.

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/in-app-calling-ios/receive-call'
```

This method takes as a parameter an `NXMCall` object with which you can answer or reject the call. An alert was implemented for you, to allow the user to choose whether to answer or reject the call.


## Answer a call

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/in-app-calling-ios/answer-call'
```

`answer:` accepts a single `completionHandler` parameter to indicate if an error occurred in the process.


## Reject a call

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/in-app-calling-ios/reject-call'
```

`reject:` accepts a single `completionHandler` parameter to indicate if an error occurred in the process.


## Hangup a call

```tabbed_content
source: '_tutorials_tabbed_content/client-sdk/get-started/in-app-voice/in-app-calling-ios/hangup-call'
```


## Handle permissions

For the call to happen, `Audio Permissions` are required. In the `appDelegate` of the sample project, you can find an implementation for the permissions request in `application:didFinishLaunchingWithOptions`.  

To read more about the permissions required, [see the setup tutorial](/client-sdk/setup/add-sdk-to-your-app/ios#add-permissions).


## Conclusion

You have implemented your first In App Voice application with the Nexmo Client SDK for iOS.

Run the app on two simulators and see that you can call, answer, reject and hangup.

If possible, test on two phones using your developer signing and provisioning facility.


