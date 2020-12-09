---
title:  NXMClient
description:  このステップでは、Vonageサーバーに対して認証を行います。

---

`NXMClient`
===========

呼び出しを発信する前に、クライアントSDKはVonageサーバーに対して認証する必要があります。`ViewController.m`には、次の追加が必要です。

ファイルの先頭で、`NexmoClient`をインポートします。

```objective_c
#import "ViewController.h"
#import <NexmoClient/NexmoClient.h>
```

`NXMClient`インスタンスおよび`NXMClientDelegate`に対する準拠をインターフェースに追加します。

```objective_c
@interface ViewController () <NXMClientDelegate>
...
@property NXMClient *client;
@end
```

JWTを追加します
---------

`viewDidLoad`の最後に、クライアントデリゲートを設定してログインします。`ALICE_JWT`を、前の手順で作成した`JWT`と必ず置き換えてください。トークンの有効期限は6時間に設定されているため、古い場合は新しいトークンを生成する必要があります。

```objective_c
- (void)viewDidLoad {
    ...
    
    self.client = NXMClient.shared;
    [self.client setDelegate:self];
    [self.client loginWithAuthToken:@"ALICE_JWT"];
}
```

クライアントデリゲート
-----------

デリゲートが機能するためには、`NXMClientDelegate`に準拠する`ViewController`を持つ必要があります。この2つのデリゲート関数をクラスに追加します。

```objective_c
- (void)client:(nonnull NXMClient *)client didChangeConnectionStatus:(NXMConnectionStatus)status reason:(NXMConnectionStatusReason)reason {
    dispatch_async(dispatch_get_main_queue(), ^{
        switch (status) {
            case NXMConnectionStatusConnected:
                self.connectionStatusLabel.text = @"Connected";
                break;
            case NXMConnectionStatusConnecting:
                self.connectionStatusLabel.text = @"Connecting";
                break;
            case NXMConnectionStatusDisconnected:
                self.connectionStatusLabel.text = @"Disconnected";
                break;
        }
    });
}

- (void)client:(nonnull NXMClient *)client didReceiveError:(nonnull NSError *)error {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.connectionStatusLabel.text = error.localizedDescription;
    });
}
```

発生するとエラーが表示され、`connectionStatusLabel`が関連する接続ステータスで更新されます。

ビルドして実行
-------

`Cmd + R`を押してビルドし、もう一度実行します：

![インターフェースが接続されました](/meta/client-sdk/ios-phone-to-app/interface-connected.png)

