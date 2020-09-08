---
title: NXMClient
description: In this step you will authenticate to the Vonage servers.
---

# `NXMClient`

Before you can place a call, the Client SDK needs to authenticate to the Vonage servers. The following additions are required to `ViewController.m`.

At the top of the file, import `NexmoClient`.

```objective_c
#import "ViewController.h"
#import <NexmoClient/NexmoClient.h>
```

Add a `NXMClient` instance and conformance to the `NXMClientDelegate` to the interface.

```objective_c
@interface ViewController () <NXMClientDelegate>
...
@property NXMClient *client;
@end
```

## Add the JWT

At the end of `viewDidLoad`, set the client delegate and log in - please make sure to replace `ALICE_JWT` for the `JWT` you created during a previous step. Please remember, the expiry time for the token was set to 6 hours so you will need to generate a new one if it is too old.

```objective_c
- (void)viewDidLoad {
    ...
    
    self.client = NXMClient.shared;
    [self.client setDelegate:self];
    [self.client loginWithAuthToken:@"ALICE_JWT"];
}
```

## The Client Delegate

For the delegate part to work, you need to have `ViewController` conform to `NXMClientDelegate`. Add these two delegate functions to the class.

```objective_c
- (void)client:(nonnull NXMClient *)client didChangeConnectionStatus:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason {
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (status) {
            case NXMConnectionStatusConnected:
                [self.callButton setAlpha:1];
                self.connectionStatusLabel.text = @"Connected";
                break;
            case NXMConnectionStatusConnecting:
                self.connectionStatusLabel.text = @"Connecting";
                break;
            case NXMConnectionStatusDisconnected:
                self.connectionStatusLabel.text = @"Disconnected";
                break;
        }
    });
}

- (void)client:(nonnull NXMClient *)client didReceiveError:(nonnull NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.connectionStatusLabel.text = error.localizedDescription;
        [self.callButton setAlpha:0];
    });
}
```

An error is shown if encountered and the `connectionStatusLabel` is updated with the relevant connection status. Also, `callButton` is shown when connected.

## Build and Run

`Cmd + R` to build and run again:

![Interface connected](/images/client-sdk/ios-voice/interface-connected.jpg)
