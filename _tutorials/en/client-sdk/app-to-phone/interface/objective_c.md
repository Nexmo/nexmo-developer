---
title: Building the interface
description: In this step you will build the only screen of the app.
---

# Building the interface

To be able to place the call, you need to add two elements to the screen:

* A `UILabel` to show the connection status
* A `UIButton` to start and end calls

Open `ViewController.h` and add these two programmatically:

```objective_c
@interface ViewController ()
@property UIButton *callButton;
@property UILabel *connectionStatusLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.connectionStatusLabel = [[UILabel alloc] init];
    self.connectionStatusLabel.text = @"Unknown";
    self.connectionStatusLabel.textAlignment = NSTextAlignmentCenter;
    self.connectionStatusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.connectionStatusLabel];
    
    self.callButton = [UIButton buttonWithType:UIButtonTypeSystem];
    self.callButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.callButton setAlpha:0];
    [self.callButton addTarget:self action:@selector(callButtonPressed) forControlEvents:UIControlEventTouchUpInside];
    [self.callButton setTitle:@"Call" forState:UIControlStateNormal];
    [self.view addSubview:self.callButton];
    
    [NSLayoutConstraint activateConstraints:@[
        [self.connectionStatusLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20],
        [self.connectionStatusLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [self.connectionStatusLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20],
        
        [self.callButton.topAnchor constraintEqualToAnchor:self.connectionStatusLabel.bottomAnchor constant:40],
        [self.callButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [self.callButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20]
    ]];
}

- (void)callButtonPressed {
    
}

@end
```

The `callButton` has been hidden, its `alpha` is set 0, and will be shown when a connection is established.

Also, a target has been added for when `callButton` is tapped and will be used to place and end calls.

## Build and Run

Run the project again (`Cmd + R`) to launch it in the simulator. 

![Interface](/images/client-sdk/ios-voice/interface.jpg)
