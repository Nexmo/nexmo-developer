---
title: Objective-C
language: objective_c
menu_weight: 2
---

Under the `//MARK: Incoming call - Reject`, implement this method to reject the incoming call:

```objective-c
- (void)didPressRejectIncomingCall:(NXMCall *)call {
    self.call = nil;
    
    __weak AppToAppCallViewController *weakSelf = self;
    [call reject:^(NSError * _Nullable error) {
        if(error) {
            NSLog(@"✆  ‼️ error rejecting call: %@", error.localizedDescription);
            [weakSelf displayAlertWithTitle:@"Reject Call" andMessage:@"Error rejecting call"];
            return;
        }
        NSLog(@"✆  🤙 call rejected");
        [weakSelf updateInterface];
    }];
}
```
