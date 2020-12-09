---
title:  NXMClient
description:  このステップでは、Vonageサーバーに対して認証を行います。

---

`NXMClient`
===========

チャットを開始する前に、クライアントSDKはVonageサーバーに対して認証する必要があります。`ViewController.m`には、次の追加が必要です。

ファイルの先頭で、`NexmoClient`と`User`をインポートします。

```objective_c
#import "ViewController.h"
#import "User.h"
#import <NexmoClient/NexmoClient.h>
```

`statusLabel`の下に`NXMClient`インスタンスと`user`プロパティを追加します。

```objective_c
@interface ViewController ()
    ...
    @property UILabel *statusLabel;
    @property NXMClient *client;
    @property User *user;
@end
```

ボタンターゲット
--------

ログインボタンが機能するためには、タップしたときに関数を実行するターゲットを追加する必要があります。`ViewController.m`ファイルに追加します：

```objective_c
@implementation ViewController
    ...

- (void)viewDidLoad {
    ...
}

- (void)setUserAsAlice {
    self.user = User.Alice;
    [self login];
}

- (void)setUserAsBob {
    self.user = User.Bob;
    [self login];
}
```

次に、2つの関数を`viewDidLoad`関数の末尾にあるそれぞれのボタンにリンクします。

```objective_c
- (void)viewDidLoad {
    ...

    [self.loginAliceButton addTarget:self action:@selector(setUserAsAlice) forControlEvents:UIControlEventTouchUpInside];
    [self.loginBobButton addTarget:self action:@selector(setUserAsBob) forControlEvents:UIControlEventTouchUpInside];
}
```

ログイン関数を追加する
-----------

`ViewController.m`の最後に、`setUserAs`関数に必要な`login`関数を追加します。この関数は、クライアントのデリゲートを設定し、ログインします。

```objective_c
@implementation ViewController
    ...

- (void)login {
    [self.client setDelegate:self];
    [self.client loginWithAuthToken:self.user.jwt];
}
```

クライアントデリゲート
-----------

デリゲートが機能するためには、`NXMClientDelegate`に準拠する`ViewController`を持つ必要があります。これを行うには、`ViewController.m`のインターフェース定義に`NXMClientDelegate`を追加する必要があります。

```objective_c
@interface ViewController () <NXMClientDelegate>

...

@end
```

次に、ファイルの最後に、次の`NXMClientDelegate`関数を追加します。

```objective_c
- (void)client:(NXMClient *)client didChangeConnectionStatus:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason {
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (status) {
            case NXMConnectionStatusConnected:
                self.statusLabel.text = @"Connected";
                break;
            case NXMConnectionStatusConnecting:
                self.statusLabel.text = @"Connecting";
                break;
            case NXMConnectionStatusDisconnected:
                self.statusLabel.text = @"Disconnected";
                break;
        }
    });
}

- (void)client:(NXMClient *)client didReceiveError:(NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.statusLabel.text = error.localizedDescription;
    });
}
```

発生するとエラーが表示され、`statusLabel`が関連する接続ステータスで更新されます。

ビルドして実行
-------

`Cmd + R`を押してビルドし、もう一度実行します。ログインボタンのいずれかをタップすると、それぞれのユーザーでクライアントにログインします：

![インターフェースが接続されました](/images/client-sdk/ios-in-app-voice/client.png)

