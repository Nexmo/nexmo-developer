---
title:  ログインインターフェースの構築
description:  このステップでは、アプリの最初の画面を作成します。

---

ログインインターフェースの構築
===============

ログインできるようにするには、画面に3つの要素を追加する必要があります：

* Aliceにログインするための`UIButton`
* Bobにログインするための`UIButton`
* 接続ステータスを示すための`UILabel`

プログラムで`ViewController.m`を開いて追加します。

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
        [self.statusLabel.leadingAnchor constraintEqualToAnchor:self.view.leadingAnchor constant:20.0],
        [self.statusLabel.trailingAnchor constraintEqualToAnchor:self.view.trailingAnchor constant:-20.0]
    ]];
}

@end
```

ビルドして実行
-------

プロジェクトをもう一度実行して（`Cmd + R`）、シミュレータで起動します。

![インターフェース](/images/client-sdk/ios-in-app-voice/login.png)

