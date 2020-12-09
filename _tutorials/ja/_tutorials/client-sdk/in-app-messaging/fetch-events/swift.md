---
title:  チャットイベント
description:  このステップでは、チャットイベントを処理します。

---

チャットイベント
========

以前は、Nexmo CLIでカンバセーションを作成し、そのカンバセーションに2人のユーザーを追加しました。クライアントSDK内の`NXMConversation`オブジェクトとしてモデル化されたカンバセーションは、ユーザーが通信する手段です。カンバセーションの詳細については、[カンバセーションAPIドキュメント](/conversation/concepts/conversation)を参照してください。チャットイベント、または`NXMEvent`オブジェクトは、作成したカンバセーションを使用して送信されるため、チャットイベントを取得するには、まずカンバセーションを取得する必要があります。これを実装するには、次のセクションに示す`ChatViewController.swift` への追加が必要です。

`conversationTextView`の下に、カンバセーションとイベントのプロパティを追加します：

```swift
class ChatViewController: UIViewController {
    ...
    let conversationTextView = UITextView()

    var conversation: NXMConversation?
    var events: [NXMEvent]? {
        didSet {
            processEvents()
        }
    }
    ...
}
```

`viewDidLoad`関数の最後に、`getConversation`へ関数呼び出しを追加します：

```swift
override func viewDidLoad() {
    ...

    getConversation()
}
```

カンバセーション、イベントを取得し、それらのイベントを`ChatViewController.swift`ファイルの最後に処理するための関数を追加します：

```swift
class ChatViewController: UIViewController {
    ...
    func getConversation() {
        client.getConversationWithUuid(user.conversationId) { [weak self] (error, conversation) in
            self?.conversation = conversation
            if conversation != nil {
                self?.getEvents()
            }
            conversation?.delegate = self
        }
    }
    
    func getEvents() {
        guard let conversation = self.conversation else { return }
        conversation.getEventsPage(withSize: 100, order: .asc) { (error, page) in
            self.events = page?.events
        }
    }
    
    func processEvents() {
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.conversationTextView.text = ""
            self.events?.forEach { event in
                if let memberEvent = event as? NXMMemberEvent {
                    self.showMemberEvent(event: memberEvent)
                }
                if let textEvent = event as? NXMTextEvent {
                    self.showTextEvent(event: textEvent)
                }
            }
        }
    }
    
    func showMemberEvent(event: NXMMemberEvent) {
        switch event.state {
        case .invited:
            addConversationLine("(event.member.user.name) was invited.")
        case .joined:
            addConversationLine("(event.member.user.name) joined.")
        case .left:
            addConversationLine("(event.member.user.name) left.")
        @unknown default:
            fatalError("Unknown member event state.")
        }
    }

    func showTextEvent(event: NXMTextEvent) {
        if let message = event.text {
            addConversationLine("(event.fromMember?.user.name ?? "A user") said: '(message)'")
        }
    }

    func addConversationLine(_ line: String) {
        if let text = conversationTextView.text, text.count > 0 {
            conversationTextView.text = "(text)\n(line)"
        } else {
            conversationTextView.text = line
        }
    }
}
```

`getConversation` Nexmo CLIからのカンバセーションIDを使用してカンバセーションを取得します。成功した場合は、`getEvents`が呼び出されてチャットイベントが取得されます。クライアント SDKはページネーションをサポートしているため、チャットイベントを取得するには、ページサイズを指定する必要があります。

イベントが取得されると、`processEvents`によって処理されます。`processEvents`には、`NXMMemberEvent`または`NXMTextEvent`のいずれかに型キャストがあり、それぞれ`showMemberEvent`と`showTextEvent`によって`conversationTextView`に追加されます。サポートされているイベントタイプの詳細については、[カンバセーションAPIドキュメント](/conversation/concepts/event)を参照してください。

会話デリゲート
-------

また、アプリケーションは最初にロードした後にカンバセーション内のイベントに反応する必要があるため、`ChatViewController`を`NXMConversationDelegate`に準拠させる必要があります。ファイルの末尾に、次の項目を追加します：

```swift
extension ChatViewController: NXMConversationDelegate {
    func conversation(_ conversation: NXMConversation, didReceive error: Error) {
        NSLog("Conversation error: (error.localizedDescription)")
    }

    func conversation(_ conversation: NXMConversation, didReceive event: NXMTextEvent) {
        self.events?.append(event)
    }
}
```

新しいイベントが受信されると、それは順番に、再びイベントの処理を開始する`events`配列に追加されます。

ビルドして実行
-------

`Cmd + R`を押してビルドし、もう一度実行します。ログイン後、両方のユーザーが期待どおりに会話に参加していることがわかります：

![接続イベントとのチャットインターフェース](/images/client-sdk/ios-messaging/chatevents.png)

