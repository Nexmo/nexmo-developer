---
title: Objective-C
language: objective_c
menu_weight: 2
---

Open `MainViewController.m`. Explore the setup methods that were written for you on `viewDidLoad`.

Now locate the following line `#pragma mark - Tutorial Methods` and complete the `setupNexmoClient` method implementation:

```objective-c
- (void)setupNexmoClient {
    self.nexmoClient = [[NXMClient alloc] initWithToken:self.selectedUser.token];
    [self.nexmoClient setDelegate:self];
    [self.nexmoClient login];
}
```

Notice that `self` is set to be the delegate for `NXMClient`. Do not forget to adopt the `NXMClientDelegate` protocol and implement the required methods.

Add the required protocol adoption declaration to the class extension located in the `MainViewController.m` file:

```objective-c
@interface MainViewController () <NXMClientDelegate>
```

The `NXMClientDelegate` indicates if the login was successful and you can start using the SDK.

Add the following method under the `#pragma mark NXMClientDelegate` line.

```objective-c
- (void)connectionStatusChanged:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason {
    [self setWithConnectionStatus:status];
}
```
