---
title: Objective-C
language: objective_c
menu_weight: 2
---

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
