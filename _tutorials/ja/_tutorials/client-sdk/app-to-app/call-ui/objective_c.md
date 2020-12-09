---
title:  通話インターフェースの構築
description:  このステップでは、アプリの2番目の画面を作成します。

---

通話インターフェースの構築
=============

通話できるようにするには、通話インターフェース用の新しいビューコントローラーを作成する必要があります。Xcodeメニューから`File`＞`New`＞`File...`を選択します。 *[Cocoa Touch Class (Cocoaタッチクラス)]* を選択し、`UIViewController`のサブクラスと`Objective-C`の言語で`CallViewController`という名前を付けます。

![Xcode追加ファイル](/images/client-sdk/ios-in-app-voice/callviewcontrollerobjc.png)

これにより、インポートされた`NexmoClient`と`User`の上部に`CallViewController.m`という新しいファイルが作成されます。

```objective_c
#import "User.h"
#import <NexmoClient/NexmoClient.h>
```

通話インターフェースには次のものが必要です：

* 通話を開始するための`UIButton`
* 通話を終了するための`UIButton`
* ステータスの更新を表示するための`UILabel`

プログラムで`CallViewController.m`を開いて追加します。

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

通話の繰り返し`DispatchQueue.main.async`を避けるために、2つのヘルパー関数`setHangUpButtonHidden`と`setStatusLabelText`があります。`UIKit`の要求に応じて、メインスレッド上でUI要素の状態を変更する必要があるためです。アクティブな通話中にだけ表示される必要があるため、この`setHangUpButtonHidden`関数が、`hangUpButton`の表示／非表示を切り替えます。

プレゼンテーション `CallViewController`
------------------------------

通話インターフェースが構築されたので、前に構築したログイン画面からビューコントローラーを提示する必要があります。ログインしたユーザーに関する情報を2つのビューコントロール間で受け渡す必要があります。`ChatViewController.h`内で、ファイルの先頭にある`User`クラスをインポートします。

```objective_c
#import <UIKit/UIKit.h>
#import "User.h"
```

インターフェースにイニシャライザーを追加します。

```objective_c
@interface ChatViewController : UIViewController

-(instancetype)initWithUser:(User *)user;

@end
```

次に`CallViewController.m`で、ユーザーとクライアントプロパティをインターフェースに追加します。

```objective_c
@interface ChatViewController ()
...
@property User *user;
@property NXMClient *client;
@end
```

イニシャライザーを実装します：

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

これは、パラメータとして`User.type`を持つクラスのカスタムイニシャライザーを定義し、ローカルの`user`プロパティに格納されます。これでユーザー情報が得られたので、`callButton`を使用してユーザーが通話する相手を表示し、`viewDidLoad`に次の内容を追加します。

```objective_c
self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Logout" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
[self.callButton setTitle:[NSString stringWithFormat:@"Call %@", self.user.callPartnerName];
if ([self.user.name isEqualToString:@"Alice"]) {
    [self.callButton setAlpha:0];
}
```

これにより、Aliceの通話ボタンが非表示になります。このデモでは、BobだけがAliceに電話をかけることができるからです。本番アプリケーションでは、アプリケーションの回答URLによって返される`NCCO`は、これを避けるために正しいユーザー名を動的に返します。また、ナビゲーションバーにログアウトボタンが作成され、末尾に対応する`logout`関数が追加されます `CallViewController.m`

```objective_c
@implementation ChatViewController
    ...
- (void)logout {
    [self.client logout];
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
```

これで、通話インターフェースをユーザー情報とともに提示する準備ができました。これを行うには、`ViewController.m`ファイル内の`NXMClientDelegate`拡張子を編集する必要があります。

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

次に、ファイルの先頭に`CallViewController`をインポートします。

```objective_c
...
#import "CallViewController.h"
```

ユーザーが正常に接続すると、必要なユーザーデータが`CallViewController`に表示されます。

ビルドして実行
-------

プロジェクトをもう一度実行して（`Cmd + R`）、シミュレータで起動します。いずれかのユーザーでログインすると、通話インターフェースが表示されます

![通話インターフェース](/images/client-sdk/ios-in-app-voice/call.png)

