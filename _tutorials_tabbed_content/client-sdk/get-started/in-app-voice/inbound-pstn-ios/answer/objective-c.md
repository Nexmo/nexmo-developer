---
title: Objective-C
language: objective_c
menu_weight: 2
---

Under the `//MARK: Incoming call - Accept`, implement this method to answer the incoming call:

```objective-c
- (void)didPressAnswerIncomingCall:(NXMCall *)call {
    self.call = nil;
    self.callStatus = CallStatusInitiated;
    [self updateInterface];
    
    __weak ReceivePhoneCallViewController *weakSelf = self;
    self.call = call;
    [call answer:^(NSError * _Nullable error) {
        if(error) {
            NSLog(@"✆  ‼️ error answering call: %@", error.localizedDescription);
            [weakSelf displayAlertWithTitle:@"Answer Call" andMessage:@"Error answering call"];
            weakSelf.call = nil;
            [weakSelf updateInterface];
            return;
        }
        [weakSelf.call setDelegate:self];
        NSLog(@"✆  🤙 call answered");
        [weakSelf updateInterface];
    }];
}
```