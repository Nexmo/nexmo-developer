---
title:  チャットイベント
description:  このステップでは、チャットイベントを処理します。

---

チャットイベント
========

以前は、Nexmo CLIでカンバセーションを作成し、そのカンバセーションに2人のユーザーを追加しました。クライアントSDK内の`NXMConversation`オブジェクトとしてモデル化されたカンバセーションは、ユーザーが通信する手段です。カンバセーションの詳細については、[カンバセーションAPIドキュメント](/conversation/concepts/conversation)を参照してください。チャットイベント、または`NXMEvent`オブジェクトは、作成したカンバセーションを使用して送信されるため、チャットイベントを取得するには、まずカンバセーションを取得する必要があります。これを実装するには、次のセクションに示す`ChatViewController.m` への追加が必要です。

インターフェースで、カンバセーションとイベントのプロパティと、`NXMConversationDelegate`への適合性を追加します：

```objective_c
@interface ChatViewController () <UITextFieldDelegate, NXMConversationDelegate> 
...
@property NXMConversation *conversation;
@property NSMutableArray<NXMEvent *> *events;
@end
```

`viewDidLoad`関数の最後に、`getConversation`へ関数呼び出しを追加します：

```swift
- (void)viewDidLoad {
    ...

    [self getConversation];
}
```

カンバセーション、イベントを取得し、それらのイベントを`ChatViewController.m`ファイルの最後に処理するための関数を追加します：

```objective_c
- (void)getConversation {
    [self.client getConversationWithUuid:self.user.conversationId completionHandler:^(NSError * _Nullable error, NXMConversation * _Nullable conversation) {
        self.conversation = conversation;
        if (conversation) {
            [self getEvents];
        }
        conversation.delegate = self;
    }];
}

- (void)getEvents {
    if (self.conversation) {
        [self.conversation getEventsPageWithSize:100 order:NXMPageOrderAsc completionHandler:^(NSError * _Nullable error, NXMEventsPage * _Nullable events) {
            self.events = [NSMutableArray arrayWithArray:events.events];
            [self processEvents];
        }];
    }
}

- (void)processEvents {
    dispatch_async(dispatch_get_main_queue(), ^{
        self.conversationTextView.text = @"";
        for (NXMEvent *event in self.events) {
            if ([event isMemberOfClass:[NXMMemberEvent class]]) {
                [self showMemberEvent:(NXMMemberEvent *)event];
            } else if ([event isMemberOfClass:[NXMTextEvent class]]) {
                [self showTextEvent:(NXMTextEvent *)event];
            }
        }
    });
}

- (void)showMemberEvent:(NXMMemberEvent *)event {
    switch (event.state) {
        case NXMMemberStateInvited:
            [self addConversationLine:[NSString stringWithFormat:@"%@ was invited", event.member.user.name]];
            break;
        case NXMMemberStateJoined:
            [self addConversationLine:[NSString stringWithFormat:@"%@ joined", event.member.user.name]];
            break;
        case NXMMemberStateLeft:
            [self addConversationLine:[NSString stringWithFormat:@"%@ left", event.member.user.name]];
            break;
    }
}

- (void)showTextEvent:(NXMTextEvent *)event {
    NSString *message = [NSString stringWithFormat:@"%@ said %@", event.fromMember.user.name, event.text];
    [self addConversationLine:message];
}

- (void)addConversationLine:(NSString *)line {
    NSString *currentText = self.conversationTextView.text;
    
    if (currentText.length > 0) {
        self.conversationTextView.text = [NSString stringWithFormat:@"%@\n%@", currentText, line];
    } else {
        self.conversationTextView.text = line;
    }
}
```

`getConversation` Nexmo CLIからのカンバセーションIDを使用してカンバセーションを取得します。成功した場合は、`getEvents`が呼び出されてチャットイベントが取得されます。クライアント SDKはページネーションをサポートしているため、チャットイベントを取得するには、ページサイズを指定する必要があります。

イベントが取得されると、`processEvents`によって処理されます。`processEvents`には、`NXMMemberEvent`または`NXMTextEvent`のいずれかに型キャストがあり、それぞれ`showMemberEvent`と`showTextEvent`によって`conversationTextView`に追加されます。サポートされているイベントタイプの詳細については、[カンバセーションAPIドキュメント](/conversation/concepts/event)を参照してください。

会話デリゲート
-------

アプリケーションは、最初にロードした後に会話内のイベントにも反応する必要があるため、`NXMConversationDelegate`からいくつかの関数を実装する必要があります。`ChatViewController.m`クラスの最後に、次のように追加します：

```objective_c
@implementation ViewController
    ...

- (void)conversation:(NXMConversation *)conversation didReceiveTextEvent:(NXMTextEvent *)event {
    [self.events addObject:event];
    [self processEvents];
}

- (void)conversation:(NXMConversation *)conversation didReceiveMemberEvent:(NXMMemberEvent *)event {
    [self.events addObject:event];
    [self processEvents];
}

- (void)conversation:(NXMConversation *)conversation didReceive:(NSError *)error {
    NSLog(@"Conversation error: %@", error.localizedDescription);
}
```

新しいイベントが受信されると、それは`events`配列に追加され、その後、イベントの処理が再び開始されます。

ビルドして実行
-------

`Cmd + R`を押してビルドし、もう一度実行します。ログイン後、両方のユーザーが期待どおりに会話に参加していることがわかります：

![接続イベントとのチャットインターフェース](/images/client-sdk/ios-messaging/chatevents.png)

