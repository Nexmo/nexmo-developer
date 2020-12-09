---
title:  呼び出しを受信する
description:  このステップでは、呼び出しを受信します。

---

呼び出しを受信する
=========

`ViewController`クラスの先頭で、`client`宣言のすぐ下に、進行中の呼び出しへの参照を保持する`NXMCall`プロパティを追加します。

```objective_c
 @interface ViewController () <NXMClientDelegate>
 ...
 @property NXMCall * call;
 @end
```

アプリケーションが呼び出しを受信すると、呼び出しを受け入れるか拒否するオプションを提供したくなります。これを行うには、`displayIncomingCallAlert`関数を`ViewController`クラスに追加します。

```objective_c
- (void)displayIncomingCallAlert:(NXMCall *)call {
    NSString *from = call.otherCallMembers.firstObject.channel.from.data;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incoming call from" message:from preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Answer" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.call = call;
        [call answer:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Reject" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        [call reject:nil];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}
```

この`displayIncomingCallAlert`関数は、パラメータとして`NXMCall`をとります。これにより、タイプ`NXMCallMember`に該当する、呼び出しのメンバーにアクセスして着信コールの電話番号を取得できます。コールに応答するための`UIAlertAction`で、以前のプロパティにコールを割り当てることに注意してください。

`displayIncomingCallAlert`を使用するには、クライアントが`NXMCall`着信を受信したときに呼び出される関数を持つ`NXMClientDelegate`を使用する必要があります。

```objective_c
- (void)client:(NXMClient *)client didReceiveCall:(NXMCall *)call {
    dispatch_async(dispatch_get_main_queue(), ^{
        [self displayIncomingCallAlert:call];
    });
}
```

ビルドして実行
-------

もう一度`Cmd + R`を押してビルドして実行します。以前からアプリケーションとリンクされた番号を呼び出すと、警告が表示されます。あなたはピックアップすることができ、呼び出しが接続されます！

![着信呼び出し警告](/meta/client-sdk/ios-phone-to-app/alert.png)

