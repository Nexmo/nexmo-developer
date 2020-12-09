---
title:  Sending a message
description:  In this step you will build the send message functionality.

---

Sending a message
=================

In the previous step you learned about conversations and events, sending a message creates a new event and sends it via the conversation.

To send a message, add the following function to `ChatViewController.m` class:

```objective_c
@implementation ViewController
    ...

- (void)sendMessage:(NSString *)message {
    [self.inputField setUserInteractionEnabled:NO];
    [self.conversation sendText:message completionHandler:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.inputField setUserInteractionEnabled:YES];
        });
    }];
}
```

To get the text from the `inputField` you need to add another function provided by the `UITextFieldDelegate`:

```objective_c
@implementation ViewController
    ...

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text = self.inputField.text;
    
    if (text) {
        [self sendMessage:text];
    }
    self.inputField.text = @"";
    [self.inputField resignFirstResponder];
    return YES;
}
```

This delegate function is called when the return button on the keyboard is pressed.

Build and Run
-------------

`Cmd + R` to build and run again. You now have a functioning chat app\! To chat simultaneously you can run the app on two different simulators/devices:

![Sent messages](/images/client-sdk/ios-messaging/messages.png)

