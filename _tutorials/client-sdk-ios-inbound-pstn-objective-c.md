---
title: How to Receive Phone Calls with the Nexmo Client SDK on iOS using Objective-C
products: client-sdk
description: This tutorial shows you how to create a Nexmo Client SDK application that can receive phone calls on iOS using Objective-C.
languages:
    - Objective_C
---

# How to Receive Phone Calls with the Nexmo Client SDK on iOS using Objective-C

In this guide, we'll learn how to forward an incoming phone call from a Nexmo phone number to an in-app user by implementing a webhook and linking that to a Nexmo application.

You will create a simple app to receive a call. The app will automatically log in a user called Jane. After logging in, Jane is able to receive a call and perform actions such as answer, decline or hangup.

## Prerequisites

- [Create a Nexmo Application](/tutorials/client-sdk-generate-test-credentials).
- Have a [user for your Nexmo Application, with a valid JWT](/tutorials/client-sdk-generate-test-credentials).
- [Add Nexmo SDK to your project](/tutorials/client-sdk-ios-add-sdk-to-your-app).


## Application webhook

For your application to connect an income phone call to an app user, you'll need to provide a URL as the `Answer URL` webhook - we've created a [gist](https://gist.github.com/NexmoDev/ed91ac99a0b278fbdcbde72ca3599ac7) for you to use.

To add this URL, go to your [Nexmo dashboard](https://dashboard.nexmo.com), navigate to [applications](https://dashboard.nexmo.com/voice/your-applications), select your application and click the 'Edit' button.

Now, set the application's `Answer URL` to: 

``https://gist.githubusercontent.com/NexmoDev/ed91ac99a0b278fbdcbde72ca3599ac7/raw/4a134363f8b3bbebae27f04095a57d0cebc5a1be/ncco.json``

and click 'Save changes'.

For more information on Nexmo application please visit the Nexmo [API Reference](https://developer.nexmo.com/api/application) and the [Nexmo Call Control Object (NCCO)](https://developer.nexmo.com/voice/voice-api/ncco-reference) reference.

## Create the project

Clone this [Github project](https://github.com/Nexmo/Client-Get-Started-PhoneToApp-Voice-ObjectiveC).

From the Github project you cloned, open the Starter app using XCode:
    
1. Open `IAVAppDefine.h` file and replace the user token:

    ```objective-c
        #define kInAppVoiceJaneToken @"JANE_TOKEN" //TODO: replace with a token for Jane
    ```

2. Open `MainViewController.m` file and make sure the following lines exist:

 * `#import <NexmoClient/NexmoClient.h>` - imports the sdk
 * `@property NXMClient *nexmoClient;` - property for the client instance
 * `@property NXMCall *ongoingCall;` - property for the call instance


## Login

Using the Nexmo Client SDK should start with logging in to `NexmoClient`, using a `jwt` user token.

In production apps, your server would authenticate the user, and would return a [correctly configured JWT](/client-sdk/concepts/jwt-acl) to your app.

For testing and getting started purposes, you can use the Nexmo CLI to [generate JWTs](/tutorials/client-sdk-generate-test-credentials).

Open `MainViewController.m`. Explore the setup instructions that were written for you on `viewDidLoad`.

Now locate the following line `#pragma mark - Tutorial Methods` and complete the `setupNexmoClient` method implementation:

```objective-c
- (void)setupNexmoClient {
    self.nexmoClient = [[NXMClient alloc] initWithToken:kInAppVoiceJaneToken];
    [self.nexmoClient setDelegate:self];
    [self.nexmoClient login];
}
```

Notice that `self` is set to be the delegate for `NXMClient`. Do not forget to adopt the `NXMClientDelegate` protocol and implement the required methods.

Add the required protocol adoption declaration to the class extension located in the `MainViewController.m` file:

```objective-c
@interface MainViewController () <NXMClientDelegate>
```

The `NXMClientDelegate` indicates if the login was successful and you can start using the SDK.

Add the following method under the `#pragma mark NXMClientDelegate` line.

```objective-c
- (void)connectionStatusChanged:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason {
    self.connectionStatus = status;
    [self updateInterface];
}
```

At this point you should already be able to run the app and see that you can login successfully with the SDK.

## Receive incoming call

When Jane calls Joe, Joe should be notified, so that Joe may decide to answer or reject the call.

This is done by implementing the optional `incomingCall:` method which is declared in the `NXMClientDelegate`.

Go back to the `#pragma mark NXMClientDelegate` line and add the `incomingCall:' method

```objective-c
- (void)incomingCall:(nonnull NXMCall *)call {
    self.ongoingCall = call;
    [self displayIncomingCallAlert];
}
```

This method takes as a parameter an `NXMCall` object with which you can answer or reject the call. An alert was implemented for you, to allow the user to choose whether to answer or reject the call.

## Answer a call

Under the `#pragma mark IncomingCall`, implement this method to answer the incoming call:

```objective-c
- (void)didPressAnswerIncomingCall {
    __weak MainViewController *weakSelf = self;
    [weakSelf.ongoingCall answer:self completionHandler:^(NSError * _Nullable error) {
        if(error) {
            [weakSelf displayAlertWithTitle:@"Answer Call" andMessage:@"Error answering call"];
            weakSelf.ongoingCall = nil;
            weakSelf.isInCall = NO;
            [self updateCallStatusLabelWithText:@""];
            [weakSelf setActiveViews];
            return;
        }
        self.isInCall = YES;
        [weakSelf setActiveViews];
    }];
}
```

`answer:completionHandler` accepts an object adopting the `NXMCallDelegate`, and a `completionHandler`, to indicate if an error occurred in the process. You already implemented `NXMCallDelegate` in a previous step.

## Reject a call

Under the `#pragma mark IncomingCall`, implement this method to reject the incoming call:

```objective-c
- (void)didPressRejectIncomingCall {
    __weak MainViewController *weakSelf = self;
    [weakSelf.ongoingCall reject:^(NSError * _Nullable error) {
        if(error) {
            [weakSelf displayAlertWithTitle:@"Reject Call" andMessage:@"Error rejecting call"];
            return;
        }

        weakSelf.ongoingCall = nil;
        weakSelf.isInCall = NO;
        [self updateCallStatusLabelWithText:@""];
        [weakSelf setActiveViews];
    }];
}
```

`reject:` accepts a single `completionHandler` parameter to indicate if an error occurred in the process.

## Call Delegate

As with `NXMClient`, `NXMCall` also has a delegate. Add the required protocol adoption declaration to the class extension located in the `MainViewController.m` file:

```objective-c
@interface MainViewController () <NXMClientDelegate, NXMCallDelegate>
```

Copy the following implementation for the `statusChanged` method of the `NXMCallDelegate` along with the aid methods under the `#pragma mark NXMCallDelegate` line:

```objective-c
- (void)statusChanged:(NXMCallMember *)callMember {
    [self updateCallStatusLabelWithStatus:callMember.status];
}
```

The `statusChanged:` method notifies on changes that happens to members on the call.  


## Hangup a call

Once Jane presses the "End Call" button, it is time to hangup the call. Implement `endCall:` method and call hangup for `myCallMember`.

```objective-c
- (IBAction)endCall:(id)sender {
    [self.ongoingCall.myCallMember hangup];
}
```

Updates for `callMember` statuses are received in `statusChanged` as part of the `NXMCallDelegate` as you have seen before.  

Update the implementation for `statusChanged` to handle call hangup:

```objective-c
- (void)statusChanged:(NXMCallMember *)callMember {
    [self updateCallStatusLabelWithStatus:callMember.status];
    
    //Handle Hangup
    if(callMember.status == NXMCallMemberStatusCancelled || callMember.status == NXMCallMemberStatusCompleted) {
        self.ongoingCall = nil;
        self.isInCall = NO;
        [self updateCallStatusLabelWithText:@"Call ended"];
        [self updateInterface];
    }
}

```

## Handle permissions

For the call to happen, `Audio Permissions` are required. In the `appDelegate` of the sample project, you can find an implementation for the permissions request in `application:didFinishLaunchingWithOptions`.  

To read more about the permissions required, [see the setup tutorial](/tutorials/client-sdk-ios-add-sdk-to-your-app#add-permissions).

## Conclusion

You have implemented your first Phone to App Voice application with the Nexmo Client SDK for iOS using Objective-C.

Run the app on a simulatos and see that you can answer, reject and hangup a call received on the phone number associated with your Nexmo application.

If possible, test on a device using your developer signing and provisioning facility.

