---
title: Receive a call
description: In this step you will receive the call.
---

# Receive a call

At the top of the `ViewController` class, just below the `client` declaration, add a `NXMCall` property to hold a reference to any call in progress.

```objective_c
 @interface ViewController () <NXMClientDelegate>
 ...
 @property NXMCall * call;
 @end
 ```

When the application receives a call we want to give the option to accept or reject the call. To do this add the `displayIncomingCallAlert` function to the `ViewController` class.

```objective_c
- (void)displayIncomingCallAlert:(NXMCall *)call {
    NSString *from = call.otherCallMembers.firstObject.channel.from.data;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incoming call from" message:from preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Answer" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.call = call;
        [call answer:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Reject" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [call reject:nil];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
```
The `displayIncomingCallAlert` function takes a `NXMCall` as a parameter, with this we can access the members, which are the type `NXMCallMember`, of the call to retrieve the phone number of the incoming call. Note in the `UIAlertAction` for answering the call we assign the call to the property from earlier.

To use `displayIncomingCallAlert` you need to use the `NXMClientDelegate` which has a function that will be called when the client receives an incoming `NXMCall`.

```objective_c
- (void)client:(NXMClient *)client didReceiveCall:(NXMCall *)call {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self displayIncomingCallAlert:call];
    });
}
```

## Build and Run

Press `Cmd + R` to build and run again, when you call the number linked with your application from earlier you will be presented with an alert. You can pick up and the call will be connected!

![Incoming call alert](/meta/client-sdk/ios-phone-to-app/alert.png)

