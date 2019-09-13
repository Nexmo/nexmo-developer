---
title: Objective-C
language: objective_c
menu_weight: 2
---

Go back to the `//MARK: NXMClientDelegate` line and add the `client:didReceiveCall:' method:

```objective-c
- (void)client:(nonnull NXMClient *)client didReceiveCall:(nonnull NXMCall *)call {
    NSLog(@"✆  📲 Incoming Call: %@", call);
    [self displayIncomingCallAlert:call];
}


- (void)displayIncomingCallAlert:(NXMCall *)call {
    if(![NSThread isMainThread]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self displayIncomingCallAlert:call];
        });
        return;
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Incoming Call" message: [self callee].name preferredStyle:UIAlertControllerStyleAlert];
    
    __weak AppToAppCallViewController *weakSelf = self;
    UIAlertAction* answerAction = [UIAlertAction actionWithTitle:@"Answer" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf didPressAnswerIncomingCall:call];
    }];
    
    UIAlertAction* rejectAction = [UIAlertAction actionWithTitle:@"Reject" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf didPressRejectIncomingCall:call];
    }];
    
    [alertController addAction:answerAction];
    [alertController addAction:rejectAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

```
