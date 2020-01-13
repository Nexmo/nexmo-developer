---
title: Objective-C
language: objective_c
menu_weight: 3
---


Have a `ViewController`, or similar, conform to `NXMClientDelegate`: 

```objective_c
@interface ViewController () <NXMClientDelegate>
...
@end

@implementation ViewController
...

//MARK:- NXMClientDelegate


- (void)client:(nonnull NXMClient *)client didChangeConnectionStatus:(NXMConnectionStatus)status 
        reason:(NXMConnectionStatusReason)reason {
    // handle connection status changed - eg: logout
    ...
}

- (void)client:(nonnull NXMClient *)client didReceiveError:(nonnull NSError *)error {
    NSLog(@"connection error: %@", [error localizedDescription]);
    // handle client connection failure
    ...
}

- (void)client:(nonnull NXMClient *)client didReceiveCall:(nonnull NXMCall *)call {
    NSLog(@"Incoming Call: %@", call);
    // handle incoming call
    ...
}
@end

```
