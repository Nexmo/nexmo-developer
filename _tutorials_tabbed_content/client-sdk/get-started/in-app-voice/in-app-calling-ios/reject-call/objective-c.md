---
title: Objective-C
language: objective_c
menu_weight: 2
---

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
