---
title: Objective-C
language: objective_c
menu_weight: 2
---

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
