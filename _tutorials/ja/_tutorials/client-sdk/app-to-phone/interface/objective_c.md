---
title:  インターフェースの構築
description:  このステップでは、アプリの画面のみを構築します。

---

インターフェースの構築
===========

通話を発信できるようにするには、画面に2つの要素を追加する必要があります：

* 接続ステータスを示すための`UILabel`
* 通話を開始および終了する`UIButton`

プログラムで`ViewController.h`を開いて、これら2つを追加します：

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

`callButton`は非表示になり、その`alpha`が0に設定され、接続が確立されたときに表示されます。

また、`callButton`がタップされたときのターゲットが追加され、通話の発信と終了に使用されます。

ビルドして実行
-------

プロジェクトをもう一度実行して（`Cmd + R`）、シミュレータで起動します。

![インターフェース](/images/client-sdk/ios-voice/interface.jpg)

