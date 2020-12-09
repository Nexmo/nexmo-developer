---
title:  インタフェースの構築
description:  このステップでは、アプリの画面のみを構築します。

---

インタフェースの構築
==========

アプリの接続状態を表示できるようにするには、画面に`UILabel`要素を追加する必要があります。プログラムで`ViewController.swift`を開いて追加します。

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

ビルドして実行
-------

プロジェクトをもう一度実行して（`Cmd + R`）、シミュレータで起動します。

![インタフェース](/meta/client-sdk/ios-phone-to-app/interface.png)

