---
title: Objective-C
language: objective_c
menu_weight: 2
---


Implement the `callNumber:` method to start a call. 

```swift
- (IBAction)callNumber:(id)sender {
    if(!self.ongoingCall) {
        [self startCall];
    } else {
        [self endCall];
    }
}
```

If a call is already in progress, taping the button will end it. 


Implement the `startCall` method to start a call. It will start the call, and also update the interface to show that a call is in progress:

```objective-c
- (void)startCall {
    if(self.ongoingCall) {
        return;
    }
    self.statusLabel.text = @"Calling...";
    [self.loadingIndicator startAnimating];
    self.callButton.alpha = 0;
    [self.nexmoClient call:@[@"CALLEE_NUMBER"] callHandler:NXMCallHandlerServer delegate:self completion:^(NSError * _Nullable error, NXMCall * _Nullable call) {
        if(error) {
            NSLog(@"❌❌❌ call not created: %@", error);
            self.ongoingCall = nil;
            [self updateInterface];
            return;
        }
        NSLog(@"🤙🤙🤙 call: %@", call);
        self.ongoingCall = call;
        self.ongoingCall.delegate = self;
        [self updateInterface];
    }];
}
```


