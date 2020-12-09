---
title:  通話を発信する
description:  このステップでは、アプリからアプリへの通話を発信する方法を学びます。

---

通話を発信する
=======

通話を発信するには、`CallViewController` UIの`callButton`を使用します。まず、`viewDidLoad`関数内のボタンにターゲットを追加する必要があります。

```objective_c
- (void)viewDidLoad {
    ...
    [self.callButton addTarget:self action:@selector(makeCall) forControlEvents:UIControlEventTouchUpInside];
}
```

`callButton`をタップすると、`makeCall`関数が呼び出されます。`CallViewController.m`クラスの最後に追加します。

```objective_c
- (void)makeCall {
    [self setStatusLabelText:[NSString stringWithFormat:@"Calling %@", self.user.callPartnerName]];
    
    [self.client call:self.user.callPartnerName callHandler:NXMCallHandlerServer completionHandler:^(NSError * _Nullable error, NXMCall * _Nullable call) {
        if (error) {
            [self setStatusLabelText:error.localizedDescription];
            return;
        }
        
        [call setDelegate:self];
        [self setHangUpButtonHidden:NO];
        self.call = call;
    }];
}
```

`makeCall`関数は、`NXMClient`インスタンスを使用して通話の発信を行います。クライアントSDKは、サーバーでの通話発信、`NCCO`を提供する応答URL、またはアプリ内での直接発信をサポートします。エラーがない場合、通話のデリゲートが設定され、通話の変更が監視できるようになり、`hangUpButton`が表示されます。

ビルドして実行
-------

`Cmd + R`を押してビルドし、もう一度実行します。これで通話アプリが機能しました！テストするには、2つの異なるシミュレータ/デバイスでアプリを実行し、Bobユーザーとしてログインしているデバイスから、Aliceユーザーとしてログインしたデバイスを呼び出すことができます：

![送信済みメッセージ](/images/client-sdk/ios-in-app-voice/active-call.png)

