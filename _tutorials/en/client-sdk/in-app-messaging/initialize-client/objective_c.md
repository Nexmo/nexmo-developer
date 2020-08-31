---
title: NXMClient
description: In this step you will authenticate to the Vonage servers.
---

# `NXMClient`

Before you can start a chat, the Client SDK needs to authenticate to the Vonage servers. The following additions are required to `ViewController.m`.

At the top of the file, import `NexmoClient` and `User`.

```objective_c
#import "ViewController.h"
#import "User.h"
#import <NexmoClient/NexmoClient.h>
```

Add a `NXMClient` instance and `user` property below the `statusLabel`.

```objective_c
@interface ViewController ()
    ...
    @property UILabel *statusLabel;
    @property NXMClient *client;
    @property User *user;
    
@end
```

## Button targets

For the log in buttons to work, you need to add targets to them which will run a function when they are tapped. In the `ViewController.m` file add the following.

```objective_c
@implementation ViewController
    ...

- (void)viewDidLoad {
    ...
}

- (void)setUserAsAlice {
    self.user = User.Alice;
    [self login];
}

- (void)setUserAsBob {
    self.user = User.Bob;
    [self login];
}
```

Then link the two functions them to their respective buttons at the end of the `viewDidLoad` function.

```objective_c
- (void)viewDidLoad {
    ...

    [self.loginAliceButton addTarget:self action:@selector(setUserAsAlice) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBobButton addTarget:self action:@selector(setUserAsBob) forControlEvents:UIControlEventTouchUpInside];
}
```

## Add the log in function

At the end of `ViewController.m`, add the `login` function needed by the `setUserAs` functions. This function sets the client's delegate and logs in.

```objective_c
@implementation ViewController
    ...

- (void)login {
    [self.client setDelegate:self];
    [self.client loginWithAuthToken:self.user.jwt];
}
```

## The client delegate

For the delegate to work, you need to have `ViewController` conform to `NXMClientDelegate`. To do this you will need to add the `NXMClientDelegate` to the interface definition for `ViewController.m`.

```objective_c
@interface ViewController () <NXMClientDelegate>

...

@end
```


Then at the end of the file, add the following `NXMClientDelegate` functions.

```objective_c
- (void)client:(NXMClient *)client didChangeConnectionStatus:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason {
    switch (status) {
        case NXMConnectionStatusConnected:
            self.statusLabel.text = @"Connected";
            break;
        case NXMConnectionStatusConnecting:
            self.statusLabel.text = @"Connecting";
            break;
        case NXMConnectionStatusDisconnected:
            self.statusLabel.text = @"Disconnected";
            break;
    }
}

- (void)client:(NXMClient *)client didReceiveError:(NSError *)error {
    self.statusLabel.text = error.localizedDescription;
}
```

An error is shown if encountered and the `statusLabel` is updated with the relevant connection status. 

## Build and Run

Press `Cmd + R` to build and run again. If you tap on one of the log in buttons it will log the client in with the respective user:

![Interface connected](/images/client-sdk/ios-messaging/client.png)
