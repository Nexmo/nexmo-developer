---
title: Objective-C
language: objective_c
menu_weight: 2
---

As with `NXMClient`, `NXMCall` also receives a delegate which you supplied in the `call:callHandler:delegate:completion:` method.  

You will now adopt the `NXMCallDelegate` for `ViewController`:

```objective-c
@interface ViewController () <NXMClientDelegate, NXMCallDelegate>

```

Copy the following implementation for the `statusChanged` method of the `NXMCallDelegate` along with the aid methods under the `#pragma mark NXMCallDelegate` line:

```objective-c
- (void)statusChanged:(NXMCallMember *)callMember {
    if (![callMember.user.userId  isEqual: kJaneUserId]) {
        self.callStatus = callMember.status;
    }
    //Handle Hangup
    if(callMember.status == NXMCallMemberStatusCancelled || callMember.status == NXMCallMemberStatusCompleted) {
        self.ongoingCall = nil;
        self.callStatus = NXMCallStatusDisconnected;
    }
    [self updateInterface];
}
```
