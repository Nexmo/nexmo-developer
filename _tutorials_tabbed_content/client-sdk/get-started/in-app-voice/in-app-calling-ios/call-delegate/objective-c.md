---
title: Objective-C
language: objective_c
menu_weight: 2
---

As with `NXMClient`, `NXMCall` also has a delegate. Add the required protocol adoption declaration to the class extension located in the `MainViewController.m` file:

```objective-c
@interface MainViewController () <NXMClientDelegate, NXMCallDelegate>
```

Copy the following implementation for the `statusChanged` method of the `NXMCallDelegate` along with the aid methods under the `#pragma mark NXMCallDelegate` line:

```objective-c
- (void)statusChanged:(NXMCallMember *)callMember {
    if([callMember.user.userId isEqualToString:self.selectedUser.userId]) {
        [self statusChangedForMyMember:callMember];
    } else {
        [self statusChangedForOtherMember:callMember];
    }
}

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