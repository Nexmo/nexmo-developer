---
title:  通話を受信する
description:  このステップでは、アプリ内通話を受信する方法を学びます

---

通話を受信する
=======

呼び出しインターフェースが構築されたので、通話を受信するために必要なコードを追加できるようになりました。`NXMClientDelegate`には、着信があると呼び出される関数があります。`ViewController.m`ファイルの`NXMClientDelegate`拡張子で、実装を追加します。

```objective_c
- (void)client:(NXMClient *)client didReceiveCall:(NXMCall *)call {
    [NSNotificationCenter.defaultCenter postNotificationName:@"NXMClient.incomingCall" object:call];
}
```

`CallViewController`クラスはフォアグラウンドにあり、呼び出しを処理するクラスなので、呼び出しは`NSNotification`ポストを使用して渡されます。`CallViewController`がこの通知を受信するには、それを観察する必要があります。`CallViewController.m`ファイルに追加します。

```objective_c
@implementation CallViewController

- (void)viewDidLoad {
    ...
    [NSNotificationCenter.defaultCenter addObserver:self selector:@selector(didReceiveCall:) name:@"NXMClient.incomingCall" object:nil];
    
    [self.hangUpButton addTarget:self action:@selector(endCall) forControlEvents:UIControlEventTouchUpInside];
}

- (void)didReceiveCall:(NSNotification *)notification {
    NXMCall *call = (NXMCall *)notification.object;
    dispatch_async(dispatch_get_main_queue(), ^{
        [self displayIncomingCallAlert:call];
    });
}

- (void)displayIncomingCallAlert:(NXMCall *)call {
    NSString *from = call.otherCallMembers.firstObject.channel.from.data;
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Incoming call from" message:from preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"Answer" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.call = call;
        [call answer:nil];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"Reject" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [call reject:nil];
    }]];
    
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)endCall {
    [self.call hangup];
    [self setHangUpButtonHidden:YES];
    [self setStatusLabelText:@"Ready to receive call..."];
}

@end
```

通知が受信されると、`didReceiveCall`が呼び出され、今度は`displayIncomingCallAlert`を呼び出し、通話を受け入れるか拒否するかをユーザーに提示します。ユーザーが承諾すると、通話中のユーザーが誰かわかるようにUIが更新され、`hangUpButton`が表示されます。`hangUpButton`をタップすると、`endCall`が呼び出され、通話を切断してUIを更新します。

通話デリゲート
-------

`NXMClient`と同様に、`NXMCall`にも、呼び出しの変更を処理するデリゲートがあります。`NXMCallDelegate`への適合をインターフェースに追加し、必要な関数を実装します。

```objective_c
@interface CallViewController () <NXMCallDelegate>
...
@end


@implementation CallViewController
- (void)call:(NXMCall *)call didUpdate:(NXMCallMember *)callMember withStatus:(NXMCallMemberStatus)status {
    switch (status) {
        case NXMCallMemberStatusAnswered:
            [self setStatusLabelText:[NSString stringWithFormat:@"On a call with %@", callMember.user.name]];
            break;
        case NXMCallMemberStatusCompleted:
            [self setStatusLabelText:@"Call ended"];
            [self setHangUpButtonHidden:YES];
            self.call = nil;
            break;
        default:
            break;
    }
}

- (void)call:(NXMCall *)call didReceive:(NSError *)error {
    [self setStatusLabelText:error.localizedDescription];
}

- (void)call:(NXMCall *)call didUpdate:(NXMCallMember *)callMember isMuted:(BOOL)muted {}
@end
```

次のステップでは、通話を発信するために必要なコードを追加します。

