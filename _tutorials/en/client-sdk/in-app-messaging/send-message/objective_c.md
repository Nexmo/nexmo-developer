---
title: Send a message
description: In this step you will send a message to the conversation
---

# Send a message

Inside `ConversationViewController.m`, locate the following line

`///MARK: Send a message`

and fill in the `sendMessage:` method implementation:

```objective-c
//MARK: Send a message

- (void)sendMessage:(NSString *)message {
    [self.inputTextField resignFirstResponder];
    self.inputTextField.enabled = NO;
    [self.activityIndicator startAnimating];
    [self.conversation sendText:message completionHandler:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.inputTextField.enabled = YES;
            [self.activityIndicator stopAnimating];
        });
    }];
}
```

You'll notice that, altought the message was sent, the conversation doesn't include it. We could be calling `getEvents` after sending but the SDK provides a way to receive new events.
