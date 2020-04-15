---
title: The Conversation UI
description: Walkthrough the ConversationViewController
---

# The Conversation UI

The `ConversationViewController` is responsible for displaying the conversation:

![Conversation UI](/assets/images/client-sdk/ios-messaging/conversation-ui.png)

The interface consists of three groups of elements:

- a `UIActivityIndicatorView` and a (status) `UILabel` to be shown during the initial loading
- a `UITextView` to show the conversation content
- a `UITextField` to compose the message and a `NSLayoutConstraint` for its bottom to change its vertical position when the keyboard is shown

All are referenced as `IBOutlet`s:

```objective-c
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UITextField *inputTextField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *inputTextFieldBottomConstraint;

@property (weak, nonatomic) IBOutlet UITextView *conversationTextView;
```

All the interface changes are affected inside the `updateInterface()` method; eg: when the conversation screen is showb, the loading interface will be shown:

```objective-c
- (void)updateInterface {
    if(![NSThread isMainThread]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateInterface];
        });
        return;
    }

    // default interface - loading screen
    [self.activityIndicator startAnimating];
    self.statusLabel.alpha = 1.0;
    self.statusLabel.text = @"Loading...";
    self.conversationTextView.alpha = 0;
    self.inputTextField.alpha = 0;

    ...
}
```

Please do have a look at the other lines inside `updateInterface` to understand how the interface changes as resources are being retrieved.
