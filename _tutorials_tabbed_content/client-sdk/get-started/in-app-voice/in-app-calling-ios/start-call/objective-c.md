---
title: Objective-C
language: objective_c
menu_weight: 2
---


`Call Other` button press is already connected to the `AppToAppCallViewController`.

Implement the `call:` method to start a call. It will start the call, and also update the UIViews so that Jane or Joe know the call is in progress:

```objective-c
- (IBAction)call:(id)sender {
    if (self.call != nil || self.callStatus == CallStatusInitiated) {
        [self endCall];
    } else {
        [self startCall];
    }
}

- (void)startCall {
}

- (void)endCall {
}
```

If a call is already in progress, taping the button will end it. 

Let's implement `startCall` - it will start the call, and also update the visual elements so that Jane or Joe know the call is in progress:

```objective-c
- (void)startCall {
    self.callStatus = CallStatusInitiated;
    __weak AppToAppCallViewController *weakSelf = self;
    [self.client call:[self callee].name callHandler:NXMCallHandlerInApp completionHandler:^(NSError * _Nullable error, NXMCall * _Nullable call) {
        if(error) {
            NSLog(@"✆  ‼️ call not created: %@", error);
            weakSelf.call = nil;
            [weakSelf updateInterface];
            return;
        }
        NSLog(@"✆  call: %@", call);
        weakSelf.call = call;
        [weakSelf.call setDelegate:self];
        [weakSelf updateInterface];
    }];
}
```
