---
title: Objective-C
language: objective_c
menu_weight: 2
---


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
