---
title:  通話を発信する
description:  このステップでは、通話を発信します。

---

通話を発信する
=======

インターフェースに`NXMCall`プロパティを追加して、進行中の通話への参照を保持します：

```objective_c
@interface ViewController () <NXMClientDelegate>
...
@property NXMCall * call;
@end
```

`call`プロパティが参照するオブジェクトに基づいて、`callButtonPressed`メソッドが通話の発信または終了に使用できます。`placeCall`および`endCall`メソッドは、ケースごとにトリガーされます。

下記の`PHONE_NUMBER`を、通話をしたい実際の電話番号に置き換えてください。注：gist NCCOで指定されているものと同じである必要があります：

```objective_c
- (void)callButtonPressed {
    if (self.call) {
        [self placeCall];
    } else {
        [self endCall];
    }
}

- (void)placeCall {
    [self.client call:@"PHONE_NUMBER" callHandler:NXMCallHandlerServer completionHandler:^(NSError * _Nullable error, NXMCall * _Nullable call) {
        if (error) {
            self.connectionStatusLabel.text = error.localizedDescription;
            return;
        }
        
        self.call = call;
        [self.callButton setTitle:@"End call" forState:UIControlStateNormal];
    }];
}

- (void)endCall {
    [self.call hangup];
    self.call = nil;
    [self.callButton setTitle:@"Call" forState:UIControlStateNormal];
}
```

これで完了です！これで通話を構築し、実行し、発信することができます！素晴らしい！

