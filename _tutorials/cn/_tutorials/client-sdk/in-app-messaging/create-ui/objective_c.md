---
title:  Building the log in interface
description:  In this step you will build the first screen of the app.

---

Building the log in interface
=============================

To be able to log in, you will need to add three elements to the screen:

* A `UIButton` to log in Alice
* A `UIButton` to log in Bob
* A `UILabel` to show the connection status.

Open `ViewController.m` and add it programmatically:

```objective_c
@interface ViewController ()

@property UIButton *loginAliceButton;
@property UIButton *loginBobButton;
@property UILabel *statusLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    self.client = NXMClient.shared;
    
    self.loginAliceButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.loginAliceButton setTitle:@"Log in as Alice" forState:UIControlStateNormal];
    self.loginAliceButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.loginAliceButton];
    
    self.loginBobButton = [UIButton buttonWithType:UIButtonTypeSystem];
    [self.loginBobButton setTitle:@"Log in as Bob" forState:UIControlStateNormal];
    self.loginBobButton.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.loginBobButton];
    
    self.statusLabel = [[UILabel alloc] init];
    self.statusLabel.text = @"";
    self.statusLabel.textAlignment = NSTextAlignmentCenter;
    self.statusLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.statusLabel];
    
    
    [NSLayoutConstraint activateConstraints:@[
        [self.loginAliceButton.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor],
        [self.loginAliceButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.loginAliceButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [self.loginAliceButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
        
        [self.loginBobButton.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.loginBobButton.topAnchor constraintEqualToAnchor:self.loginAliceButton.bottomAnchor constant:20.0],
        [self.loginBobButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [self.loginBobButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0],
        
        [self.statusLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
        [self.statusLabel.topAnchor constraintEqualToAnchor:self.loginBobButton.bottomAnchor constant:20.0],
        [self.loginBobButton.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [self.loginBobButton.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0]
    ]];
}

@end
```

Build and Run
-------------

Run the project again (`Cmd + R`) to launch it in the simulator.

![Interface](/images/client-sdk/ios-messaging/login.png)

