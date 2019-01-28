---
title: How to Make and Receive Voice Calls with the Nexmo Client SDK on iOS using Objective-C
products: client-sdk
description: This tutorial shows you how to create a Nexmo Client SDK application that can make and receive voice calls on iOS using Objective-C.
languages:
    - Objective_C
---

# How to Make and Receive Voice Calls with the Nexmo Client SDK on iOS using Objective-C

In this tutorial you learn how to use Nexmo Client SDK for iOS, in order to perform an in-app (IP to IP) voice call.

You will create a simple app to make a call and receive a call.

The app will have two buttons, which log in different users: Jane or Joe. After logging in, Jane and Joe are able to place a call and perform actions such as answer, decline or hangup.

## Prerequisites

- [Create a Nexmo Application](/tutorials/client-sdk-generate-test-credentials).
- Have at least [two users for your Nexmo Application, with valid JWTs](/tutorials/client-sdk-generate-test-credentials).
- Clone this [Github project](https://github.com/Nexmo/Client-Get-Started-InApp-Voice-ObjectiveC)

## Create the project

Using the Github project you cloned, in the Starter app, with XCode:
    
1. Open `IAVAppDefine.h` file and replace the user IDs and tokens:

    ```objective-c
        #define kInAppVoiceJaneUserId @"JANE_USER_ID" //TODO: replace with a userId for Jane
        #define kInAppVoiceJaneToken @"JANE_TOKEN" //TODO: replace with a token for Joe
        #define kInAppVoiceJoeUserId @"JOE_USER_ID" //TODO: replace with a userId for Joe
        #define kInAppVoiceJoeToken @"JOE_TOKEN" //TODO: replace with a token for Joe
    ```

2. Open `MainViewController.m` file and make sure the following lines exist:

 * `#import <NexmoClient/NexmoClient.h>` - imports the sdk
 * `@property NXMClient *nexmoClient;` - property for the client instance
 * `@property NXMCall *ongoingCall;` - property for the call instance

## Login

Using the Nexmo Client SDK should start with logging in to `NexmoClient`, using a `jwt` user token.

In production apps, your server would authenticate the user, and would return a [correctly configured JWT](/client-sdk/concepts/jwt-acl) to your app.

For testing and getting started purposes, you can use the Nexmo CLI to [generate JWTs](/tutorials/client-sdk-generate-test-credentials).

Open `MainViewController.m`. Explore the setup methods that were written for you on `viewDidLoad`.

Now locate the following line `#pragma mark - Tutorial Methods` and complete the `setupNexmoClient` method implementation:

```objective-c
- (void)setupNexmoClient {
    self.nexmoClient = [[NXMClient alloc] initWithToken:self.selectedUser.token];
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
    [self setWithConnectionStatus:status];
}
```

At this point you should already be able to run the app and see that you can login successfully with the SDK.

## Start a Call

You can now make a simple In-App call. If you logged in as Jane, you can call Joe, and if you logged in as Joe you can call Jane.

`Call Other` button press is already connected to the `MainViewController`.

Implement the `didCallOtherButtonPress:` method to start a call. It will start the call, and also update the UIViews so that Jane or Joe know the call is in progress:

```objective-c
- (IBAction)didCallOtherButtonPress:(UIButton *)sender {
    self.isInCall = YES;
    [self.nexmoClient call:@[self.otherUser.userId] callType:NXMCallTypeInApp delegate:self completion:^(NSError * _Nullable error, NXMCall * _Nullable call) {
        if(error) {
            self.isInCall = NO;
            self.ongoingCall = nil;
            [self updateCallStatusLabelWithText:@""];
            return;
        }
        self.ongoingCall = call;
        [self setActiveViews];
    }];
}
```

Ensure that `NSArray` is initialized with `otherUser.userId`. You can have multiple users in a call. However, this tutorial demonstrates a 1-on-1 call.

As with `NXMClient`, `NXMCall` also receives a delegate which you supplied in the `call:callType:delegate:completion:` method.  

Adopt the `NXMCallDelegate`. Your extension declaration should look like this:

```objective-c
@interface MainViewController () <NXMClientDelegate, NXMCallDelegate>

```

Copy the following implementation for the `statusChanged` method of the `NXMCallDelegate` along with the aid methods under the `#pragma mark NXMCallDelegate` line:

```objective-c
- (void)statusChanged:(NXMCallMember *)callMember {
    if([callMember.userId isEqualToString:self.selectedUser.userId]) {
        [self statusChangedForMyMember:callMember];
    } else {
        [self statusChangedForOtherMember:callMember];
    }
}

- (void)statusChangedForMyMember:(NXMCallMember *)myMember {
    [self updateCallStatusLabelWithStatus:myMember.status];
    
    //Handle Hangup

}

- (void)statusChangedForOtherMember:(NXMCallMember *)otherMember {

}
```

The `statusChanged:` method notifies on changes that happens to members on the call.  

The `statusChangedForOtherMember` and `statusChangedForMyMember` methods are updated later when you will handle call hangup.

You can build the project now and make an outgoing call. Next you implement how to receive an incoming call.

Note that while `NXMCallTypeInApp` is useful for simple calls, you can also start a call with customized logic [using an NCCO](/client-sdk/in-app-voice/concepts/ncco-guide) ), by choosing `NXMCallTypeServer` as the `callType`.

```objective-c
 [self.nexmoClient call:@[callees] callType:NXMCallTypeServer delegate:self completion:^(NSError * _Nullable error, NXMCall * _Nullable call){...}];
```

This also allows you to start a PSTN phone call, by adding a phone number to the `callees` array.

## Receive incoming call

When Jane calls Joe, Joe should be notified, so that Joe may decide to answer or decline the call.

This is done by implementing the optional `incomingCall:` method which is declared in the `NXMClientDelegate`.

Go back to the `#pragma mark NXMClientDelegate` line and add the `incomingCall:' method

```objective-c
- (void)incomingCall:(nonnull NXMCall *)call {
    self.ongoingCall = call;
    [self displayIncomingCallAlert];
}
```

This method takes as a parameter an `NXMCall` object with which you can answer or decline the call. An alert was implemented for you, to allow the user to choose whether to answer or decline the call.

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

## Decline a call

Under the `#pragma mark IncomingCall`, implement this method to decline the incoming call:

```objective-c
- (void)didPressDeclineIncomingCall {
    __weak MainViewController *weakSelf = self;
    [weakSelf.ongoingCall decline:^(NSError * _Nullable error) {
        if(error) {
            [weakSelf displayAlertWithTitle:@"Decline Call" andMessage:@"Error declining call"];
            return;
        }

        weakSelf.ongoingCall = nil;
        weakSelf.isInCall = NO;
        [self updateCallStatusLabelWithText:@""];
        [weakSelf setActiveViews];
    }];
}
```

`decline:` accepts a single `completionHandler` parameter to indicate if an error occurred in the process.

## Hangup a call

Once Jane or Joe presses the red button, it is time to hangup the call. Implement `didEndButtonPress:` method and call hangup for `myCallMember`.

```objective-c
- (IBAction)didEndButtonPress:(UIButton *)sender {
    [self.ongoingCall.myCallMember hangup];
}
```

Updates for `callMember` statuses are received in `statusChanged` as part of the `NXMCallDelegate` as you have seen before.  

Update the implementation for `statusChangedForOtherMember` and `statusChangedForMyMember` to handle call hangup:

```objective-c
- (void)statusChangedForMyMember:(NXMCallMember *)myMember {
    [self updateCallStatusLabelWithStatus:myMember.status];
    
    //Handle Hangup
    if(myMember.status == NXMCallMemberStatusCancelled || myMember.status == NXMCallMemberStatusCompleted) {
        self.ongoingCall = nil;
        self.isInCall = NO;
        [self updateCallStatusLabelWithText:@""];
        [self setActiveViews];
    }
}

- (void)statusChangedForOtherMember:(NXMCallMember *)otherMember {
    if(otherMember.status == NXMCallMemberStatusCancelled || otherMember.status == NXMCallMemberStatusCompleted) {
        [self.ongoingCall.myCallMember hangup];
    }
}
```

## Handle permissions

For the call to happen, `Audio Permissions` are required. In the `appDelegate` of the sample project, you can find an implementation for the permissions request in `application:didFinishLaunchingWithOptions`.  

To read more about the permissions required, [see the setup tutorial](/tutorials/client-sdk-ios-add-sdk-to-your-app#add-permissions).

## Conclusion

You have implemented your first In App Voice application with the Nexmo Client SDK for iOS.

Run the app on two simulators and see that you can call, answer, decline and hangup.

If possible, test on two phones using your developer signing and provisioning facility.
