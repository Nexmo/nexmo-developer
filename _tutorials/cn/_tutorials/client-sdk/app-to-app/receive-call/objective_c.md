---
title:  Receive a call
description:  In this step you learn how to receive an in-app call

---

Receiving a call
================

Now that the calling interface is built, you can now add the code needed receive a call. The `NXMClientDelegate` has a function that is called when there is an incoming call. Add an implementation for it in the `NXMClientDelegate` extension in the `ViewController.m` file.

```objective_c
- (void)client:(NXMClient *)client didReceiveCall:(NXMCall *)call {
    [NSNotificationCenter.defaultCenter postNotificationName:@"NXMClient.incomingCall" object:call];
}
```

The `CallViewController` class will be in the foreground and the class handling the call, so the call is passed along using a `NSNotification` post. For `CallViewController` to receive this notification it needs to observe it. In the `CallViewController.m` file add.

```objective_c
@implementation CallViewController

- (void)viewDidLoad {
    ...
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didReceiveCall:) name:@"NXMClient.incomingCall" object:nil];
    
    [self.hangUpButton addTarget:self action:@selector(endCall) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveCall:(NSNotification *)notification {
    NXMCall *call = (NXMCall *)notification.object;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self displayIncomingCallAlert:call];
    });
}

- (void)displayIncomingCallAlert:(NXMCall *)call {
    NSString *from = call.otherCallMembers.firstObject.channel.from.data;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incoming call from" message:from preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Answer" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.call = call;
        [call answer:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Reject" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [call reject:nil];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)endCall {
    [self.call hangup];
    [self setHangUpButtonHidden:YES];
    [self setStatusLabelText:@"Ready to receive call..."];
}

@end
```

When a notification is received `didReceiveCall` is called which in turn calls `displayIncomingCallAlert` to present the user with the option of accepting or rejecting the call. If the user accepts the UI is updated to show who the user is on a call with and the `hangUpButton` becomes visible. If the `hangUpButton` is tapped `endCall` is called which hangs up the call and updates the UI.

The call delegate
-----------------

Similar to `NXMClient`, `NXMCall` also has a delegate to handle changes to the call. Add conformance for `NXMCallDelegate` to the interface and implement the required functions.

```objective_c
@interface CallViewController () <NXMCallDelegate>
...
@end


@implementation CallViewController
- (void)call:(NXMCall *)call didUpdate:(NXMCallMember *)callMember withStatus:(NXMCallMemberStatus)status {
    switch (status) {
        case NXMCallMemberStatusAnswered:
            [self setStatusLabelText:[NSString stringWithFormat:@"On a call with %@", callMember.user.name]];
            break;
        case NXMCallMemberStatusCompleted:
            [self setStatusLabelText:@"Call ended"];
            [self setHangUpButtonHidden:YES];
            self.call = nil;
            break;
        default:
            break;
    }
}

- (void)call:(NXMCall *)call didReceive:(NSError *)error {
    [self setStatusLabelText:error.localizedDescription];
}

- (void)call:(NXMCall *)call didUpdate:(NXMCallMember *)callMember isMuted:(BOOL)muted {}
@end
```

In the next step you will add the code needed to make a call.

