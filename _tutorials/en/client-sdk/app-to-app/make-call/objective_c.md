---
title: Make a call
description: In this step you learn how to make an app-to-app call.
---

# Make a call

To make a call we will make use of the `callButton` in the `CallViewController` UI. First we need to add a target to the button in the `viewDidLoad` function.

```objective_c
- (void)viewDidLoad {
    ...
    [self.callButton addTarget:self action:@selector(makeCall) forControlEvents:UIControlEventTouchUpInside];
}
```

When the `callButton` is tapped it will call the `makeCall` function. Add it to the end of the `CallViewController.m` class.

```objective_c
- (void)makeCall {
    [self setStatusLabelText:[NSString stringWithFormat:@"Calling %@", self.user.callPartnerName]];
    
    [self.client call:self.user.callPartnerName callHandler:NXMCallHandlerServer completionHandler:^(NSError * _Nullable error, NXMCall * _Nullable call) {
        if (error) {
            [self setStatusLabelText:error.localizedDescription];
            return;
        }
        
        [call setDelegate:self];
        [self setHangUpButtonHidden:NO];
        self.call = call;
    }];
}
```

The `makeCall` function uses the `NXMClient` instance to make the call. The Client SDK supports making calls with the server, your answer URL that provides a `NCCO`, or directly in app. If there is no error the call's delegate is set so that changes to the call can be monitored and the `hangUpButton` is made visible.

## Build and run

Press `Cmd + R` to build and run again. You now have a functioning call app! To test it out you can run the app on two different simulators/devices, and call the device logged in as the Alice user from the device logged in as the Bob user:

![Sent messages](/images/client-sdk/ios-in-app-voice/active-call.png)