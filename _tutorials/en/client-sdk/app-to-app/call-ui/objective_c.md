---
title: Building the call interface
description: In this step you will build the second screen of the app.
---

# Building the call interface

To be able to call, you will need to create a new View Controller for the calling interface. From the Xcode menu, select `File` > `New` > `File...`. Choose a *Cocoa Touch Class*, name it `CallViewController` with a subclass of `UIViewController` and language of `Objective-C`.

![Xcode adding file](/images/client-sdk/ios-in-app-voice/callviewcontrollerobjc.png)

This will create a new file called `CallViewController.m`, at the top import `NexmoClient` and `User`.

```objective_c
#import "User.h"
#import <NexmoClient/NexmoClient.h>
```

The call interface will need:

* A `UIButton` to start a call
* A `UIButton` to end a call
* A `UILabel` to show status updates

Open `CallViewController.m` and add them programmatically.

```objective_c
@interface CallViewController () <NXMCallDelegate>
@property UIButton *callButton;
@property UIButton *hangUpButton;
@property UILabel *statusLabel;
@end

@implementation CallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColor.systemBackgroundColor;
    
    self.callButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.callButton setTitle:[NSString stringWithFormat:@"Call %@", self.user.callPartnerName] forState:UIControlStateNormal];
    self.callButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.callButton];
    
    self.hangUpButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.hangUpButton setTitle:@"Hang up" forState:UIControlStateNormal];
    self.hangUpButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self setHangUpButtonHidden:YES];
    [self.view addSubview:self.hangUpButton];
    
    self.statusLabel = [[UILabel alloc] init];
    [self setStatusLabelText:@"Ready to receive call..."];
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.statusLabel];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.callButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.callButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.callButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [self.callButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
        
        [self.hangUpButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.hangUpButton.topAnchor constraintEqualToAnchor:self.callButton.bottomAnchor constant:20.0],
        [self.hangUpButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [self.hangUpButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
        
        [self.statusLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.statusLabel.topAnchor constraintEqualToAnchor:self.hangUpButton.bottomAnchor constant:20.0],
        [self.statusLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [self.statusLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0]
    ]];
}

- (void)setHangUpButtonHidden:(BOOL)isHidden {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self.hangUpButton setHidden:isHidden];
        [self.callButton setHidden:!self.hangUpButton.isHidden];
    });
}

- (void)setStatusLabelText:(NSString *)text {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.statusLabel.text = text;
    });
}

@end
```

There are two helper functions `setHangUpButtonHidden` and `setStatusLabelText` to avoid repetition of calling `DispatchQueue.main.async` as changing the state of the UI elements needs to be done on the main thread as required by `UIKit`. The `setHangUpButtonHidden` function toggles the visibility of the `hangUpButton` as this only needs to be visible during an active call. 


## Presenting the `CallViewController`

Now that the calling interface is built you will need to present the view controller from the log in screen you built earlier. You will need information about the logged in user to be passed between the two view controllers, within `ChatViewController.h` import the `User` class at the top of the file.

```objective_c
#import <UIKit/UIKit.h>
#import "User.h"
```

Add an initializer to the interface.

```objective_c
@interface ChatViewController : UIViewController

-(instancetype)initWithUser:(User *)user;

@end
```

Then in `CallViewController.m`, add a user and client property to the interface.

```objective_c
@interface ChatViewController ()
...
@property User *user;
@property NXMClient *client;
@end
```

Implement the initializer:

```objective_c
@implementation CallViewController

- (instancetype)initWithUser:(User *)user {
    if (self = [super init])
    {
        _user = user;
        _client = NXMClient.shared;
    }
    return self;
}
...
@end
```

This defines a custom initializer for the class which has a `User.type` as its parameter, which then gets stored in the local `user` property. Now that we have the user information you use the `callButton` to show who the user will be calling, in `viewDidLoad` add the following.

```objective_c
self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
[self.callButton setTitle:[NSString stringWithFormat:@"Call %@", self.user.callPartnerName];
if ([self.user.name isEqualToString:@"Alice"]) {
    [self.callButton setAlpha:0];
}
```

This will hide the call button for Alice since for this demonstration only Bob will be able to make a call to Alice. In a production application the `NCCO` that is returned by your application's answer URL will dynamically return the correct username to avoid this. It also creates a logout button in the navigation bar, add the corresponding `logout` function to the end of `CallViewController.m` 

```objective_c 
@implementation ChatViewController
    ...
- (void)logout {
    [self.client logout];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
```

Now you are ready to present the calling interface along with the user information. To do this you will need to edit the `NXMClientDelegate` extension in the `ViewController.m` file.

```objective_c
- (void)client:(NXMClient *)client didChangeConnectionStatus:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason {
    switch (status) {
        case NXMConnectionStatusConnected: {
            self.statusLabel.text = @"Connected";
            UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[CallViewController alloc] initWithUser:self.user]];
            navigationController.modalPresentationStyle = UIModalPresentationOverFullScreen;
            [self presentViewController:navigationController animated:YES completion:nil];
            break;
        }
        case NXMConnectionStatusConnecting:
            self.statusLabel.text = @"Connecting";
            break;
        case NXMConnectionStatusDisconnected:
            self.statusLabel.text = @"Disconnected";
            break;
    }
}
```

Then import `CallViewController` at the top of the file.

```objective_c
...
#import "CallViewController.h"
```

If the user connects successfully a `CallViewController` will be presented with the user data needed.

## Build and Run

Run the project again (`Cmd + R`) to launch it in the simulator. If you log in with one of the users you will see the calling interface

![Call interface](/images/client-sdk/ios-in-app-voice/call.png)
