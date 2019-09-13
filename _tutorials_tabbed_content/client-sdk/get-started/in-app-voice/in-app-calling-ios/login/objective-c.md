---
title: Objective-C
language: objective_c
menu_weight: 2
---

Inside `AppToAppCallViewController`, explore the setup methods that were written for you on `viewDidLoad`.

Now locate the following line `//MARK: Setup Nexmo Client` and complete the `setupNexmoClient` method implementation:


```objective-c
- (void)setupNexmoClient {
    self.client = [NXMClient shared];
    [self.client setDelegate:self];
    [self.client loginWithAuthToken:self.user.jwt];;
}
```

Notice that `self` is set to be the delegate for `NXMClient`. Do not forget to adopt the `NXMClientDelegate` protocol and implement the required methods.

Locate the `//MARK:- NXMClientDelegate` line and add the required protocol methods:

```objective-c
- (void)client:(nonnull NXMClient *)client didChangeConnectionStatus:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason {
    [self updateInterface];
}

- (void)client:(nonnull NXMClient *)client didReceiveError:(nonnull NSError *)error {
    [self updateInterface];
}
```
