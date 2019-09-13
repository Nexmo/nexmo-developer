---
title: Objective-C
language: objective_c
menu_weight: 2
---


Implement the `call:` method to start a call. 

```objective-c
- (IBAction)call:(id)sender {
    if (self.call != nil || self.callStatus == CallStatusInitiated) {
        [self endCall];
    } else {
        [self startCall];
    }
}
```

If a call is already in progress, taping the button will end it. 


Implement the `startCall` method to start a call. It will start the call, and also update the interface to show that a call is in progress:

```objective-c
- (void)startCall {
    self.callStatus = CallStatusInitiated;
    __weak MakePhoneCallViewController *weakSelf = self;
    [self.client call:kCalleePhoneNumber callHandler:NXMCallHandlerServer completionHandler:^(NSError * _Nullable error, NXMCall * _Nullable call) {
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


