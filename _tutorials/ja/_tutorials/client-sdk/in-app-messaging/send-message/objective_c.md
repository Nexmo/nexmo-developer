---
title:  メッセージを送信する
description:  このステップでは、メッセージの送信機能を構築します。

---

メッセージを送信する
==========

会話とイベントについて学習した前のステップでは、メッセージを送信すると新しいイベントが作成され、会話経由で送信されます。

メッセージを送信するには、次の関数を`ChatViewController.m`クラスに追加します：

```objective_c
@implementation ViewController
    ...

- (void)sendMessage:(NSString *)message {
    [self.inputField setUserInteractionEnabled:NO];
    [self.conversation sendText:message completionHandler:^(NSError * _Nullable error) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.inputField setUserInteractionEnabled:YES];
        });
    }];
}
```

`inputField`からテキストを取得するには、`UITextFieldDelegate`によって提供される別の関数を追加する必要があります：

```objective_c
@implementation ViewController
    ...

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSString *text = self.inputField.text;
    
    if (text) {
        [self sendMessage:text];
    }
    self.inputField.text = @"";
    [self.inputField resignFirstResponder];
    return YES;
}
```

このデリゲート関数は、キーボードのリターンボタンが押されたときに呼び出されます。

ビルドして実行
-------

`Cmd + R` ビルドし、もう一度実行します。これでチャットアプリが機能しました！同時にチャットするには、2つの異なるシミュレータ/デバイスでアプリを実行できます：

![送信済みメッセージ](/images/client-sdk/ios-messaging/messages.png)

