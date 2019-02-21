---
title: Objective-C
language: objective_c
menu_weight: 2
---


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
