---
title: Building the interface
description: In this step you will build the only screen of the app.
---

# Building the interface

To be able view the connection status of the app you will need to add a `UILabel` element to the screen. Open `ViewController.swift` and add it programmatically.

```objective_c
@interface ViewController ()
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
    
    [NSLayoutConstraint activateConstraints:@[
        [self.connectionStatusLabel.topAnchor constraintEqualToAnchor:self.view.safeAreaLayoutGuide.topAnchor constant:20],
        [self.connectionStatusLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20],
        [self.connectionStatusLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20]
    ]];
}

@end
```

## Build and Run

Run the project again (`Cmd + R`) to launch it in the simulator. 

![Interface](/meta/client-sdk/ios-phone-to-app/interface.png)
