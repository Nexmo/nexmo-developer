---
title: Objective-C
language: objective_c
menu_weight: 2
--- 


Inside `UserSelectionViewController.m`, explore the `updateInterface()` method that was written for you and referenced from `viewDidLoad`.

Now locate the following line `//MARK: Setup Nexmo Client` and complete the `loginAs:` method:

```objective-c
-(void)loginAs:(User *)user {
    self.user = user;
    [self.client setDelegate:self];
    [self.client loginWithAuthToken:self.user.jwt];
    [self updateInterface];
}
```

This method is called when one of the two `Login as ...` buttons are tapped.

> **NOTE:** The `User` class is a simple `NSObject` subclass we've defined in the `User.h` file.

Notice that `self` is set to be the delegate for `NXMClient`. Do not forget to adopt the `NXMClientDelegate` protocol and implement the required methods.

To adopt the `NXMClientDelegate` protocol, append it to the `UserSelectionViewController` interface at the top of `UserSelectionViewController.m` file:

```objective-c
@interface UserSelectionViewController () <NXMClientDelegate>
```

Now, locate the following line `//MARK:- NXMClientDelegate` towards the end of `UserSelectionViewController.swift`, and add the required methods:

```objective-c
- (void)client:(nonnull NXMClient *)client didChangeConnectionStatus:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason {
    NSLog(@"✆  connectionStatusChanged - status: %@ - reason: %@", connectionStatusDescription(status), connectionStatusReasonDescription(reason));
    [self updateInterface];
    if (status == NXMConnectionStatusConnected && self.user != nil) {
        [self performSegueWithIdentifier:@"showMessages" sender:self.user];
    }
}

- (void)client:(nonnull NXMClient *)client didReceiveError:(nonnull NSError *)error {
    NSLog(@"✆  ‼️ connection error: %@", [error localizedDescription]);
    [self updateInterface];
}
```

The `client::didChangeConnectionStatus:reason:)` method of the `NXMClientDelegate` protocol indicates changes to the connection. 

If `status` is `NXMConnectionStatusConnected` then the user is authenticated and we're ready to move to the next screen, holding the conversation - we do this by performing the `showMessages` segue. 

