---
title: Place a call
description: In this step you will place the call.
---

# Place a call

Add a `NXMCall` property to the interface to hold a reference to any call in progress:

```objective_c
@interface ViewController () <NXMClientDelegate>
...
@property NXMCall * call;
@end
```

Based on the object referenced by the `call` property, the `callButtonPressed` method can now be used to either place or end calls; the `placeCall` and `endCall` methods are triggered for each case. 

Please make sure to replace `PHONE_NUMBER` below with the actual phone number you want to call. Note: must be the same one as the one specified in the gist NCCO:

```objective_c
- (void)callButtonPressed {
    if (self.call) {
        [self placeCall];
    } else {
        [self endCall];
    }
}

- (void)placeCall {
    [self.client call:@"PHONE_NUMBER" callHandler:NXMCallHandlerServer completionHandler:^(NSError * _Nullable error, NXMCall * _Nullable call) {
        if (error) {
            self.connectionStatusLabel.text = error.localizedDescription;
            return;
        }
        
        self.call = call;
        [self.callButton setTitle:@"End call" forState:UIControlStateNormal];
    }];
}

- (void)endCall {
    [self.call hangup];
    self.call = nil;
    [self.callButton setTitle:@"Call" forState:UIControlStateNormal];
}
```

That's it! You can now build, run and place the call! Magic!


