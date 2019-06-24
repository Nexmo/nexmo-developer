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
    [self.nexmoClient call:@[self.otherUser.userId] callHandler:NXMCallHandlerInApp delegate:self completion:^(NSError * _Nullable error, NXMCall * _Nullable call) {
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

