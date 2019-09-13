---
title: Objective-C
language: objective_c
menu_weight: 2
---

As with `NXMClient`, `NXMCall` also has a delegate. Add the required protocol methods under the `//MARK:- NXMCallDelegate` line:

```objective-c
- (void)call:(nonnull NXMCall *)call didUpdate:(nonnull NXMCallMember *)callMember withStatus:(NXMCallMemberStatus)status {
    NSLog(@"✆  🤙 Call Status update | member: %@ | status: %@", callMember.user.displayName, callMemberStatusDescriptionFor(status));
    
    // call completed
    if (status == NXMCallMemberStatusCanceled || status == NXMCallMemberStatusCompleted) {
        self.callStatus = CallStatusCompleted;
        [self.call hangup];
        self.call = nil;
    }
    
    // call error
    if ( (call.myCallMember.memberId != callMember.memberId) && (status == NXMCallMemberStatusFailed || status == NXMCallMemberStatusBusy)) {
        self.callStatus = CallStatusError;
        [self.call hangup];
        self.call = nil;
    }
    
    // call rejected
    if ( (call.myCallMember.memberId != callMember.memberId) && (status == NXMCallMemberStatusRejected)) {
        self.callStatus = CallStatusRejected;
        [self.call hangup];
        self.call = nil;
    }
    
    [self updateInterface];
}

- (void)call:(nonnull NXMCall *)call didUpdate:(nonnull NXMCallMember *)callMember isMuted:(BOOL)muted {
    [self updateInterface];
}

- (void)call:(nonnull NXMCall *)call didReceive:(nonnull NSError *)error {
    NSLog(@"✆  ‼️ call error: %@", [error localizedDescription]);
    [self updateInterface];
}

```
